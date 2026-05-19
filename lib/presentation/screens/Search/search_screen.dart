import 'package:flutter/material.dart';
import 'package:local_hero_transform/local_hero_transform.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_course_data.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/custom_bottom_sheet.dart';
import 'package:wlcd/presentation/widgets/custom_drop_down_widget.dart';
import 'package:wlcd/presentation/widgets/custom_radio_tile.dart';
import 'package:wlcd/presentation/widgets/custom_search.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController(text: 'UX Design');

  static const List<String> _sortItems = ['default', 'price-low', 'price-high', 'rating'];
  static const List<String> _levelItems = ['all', 'beginner', 'intermediate'];

  String _selectedSort = _sortItems.first;
  String _selectedLevel = _levelItems.first;
  String? _selectedTopic;
  double? _minRating;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCourses = _filteredCourses;

    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const CustomAppBar(title: 'Search Course', showBackButton: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearch(color: AppColors.white, controller: _searchController, onChanged: (_) => setState(() {})),
              SizedBox(height: AppHeight.h10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        side: BorderSide(color: AppColors.grey.withAlpha(80)),
                      ),
                      onPressed: _openFilterSheet,
                      icon: const Icon(Icons.tune, color: AppColors.primary),
                      label: const BodyTitle(text: 'Filter', color: AppColors.primary),
                    ),
                  ),
                  SizedBox(width: AppWidth.w8),
                  Expanded(
                    child: CustomDropDownWidget(
                      onChanged: (value) => setState(() => _selectedSort = value as String),
                      hintText: 'Sort by',
                      items: _sortItems,
                      isStringList: true,
                      initialItem: _selectedSort,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: AppWidth.w8),
                  Expanded(
                    child: CustomDropDownWidget(
                      onChanged: (value) => setState(() => _selectedLevel = value as String),
                      hintText: 'All levels',
                      items: _levelItems,
                      isStringList: true,
                      initialItem: _selectedLevel,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppHeight.h12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionTitle(text: '${filteredCourses.length} results', color: AppColors.text),
                  SizedBox(
                    width: AppWidth.w110,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: AppColors.primary,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.grey,
                      tabs: const [Tab(icon: Icon(Icons.grid_view_rounded)), Tab(icon: Icon(Icons.view_list_rounded))],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppHeight.h12),
              Expanded(
                child: filteredCourses.isEmpty
                    ? const Center(child: BodyTitle(text: 'No courses found'))
                    : LocalHeroViews(
                        tabController: _tabController,
                        itemCount: filteredCourses.length,
                        onPressedCard: (_) {},
                        itemsModel: (index) {
                          final course = filteredCourses[index];
                          return ItemsModel(
                            image: DecorationImage(image: NetworkImage(course.imageUrl), fit: BoxFit.cover),
                            name: Text(course.category),
                            title: Text(course.title),
                            subTitle: Text('${course.rating}  (${course.reviews})'),
                            subTitleIcon: const Icon(Icons.star, color: Colors.amber),
                            favoriteIconButton: Text('\$${course.price.toStringAsFixed(0)}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openFilterSheet() async {
    final topic = await CustomBottomSheet.show<String>(
      context,
      title: 'Filter',
      heightFactor: .8,
      isScroll: false,
      body: _SearchFilterSheet(
        initialTopic: _selectedTopic,
        initialRating: _minRating,
        initialLevel: _selectedLevel,
      ),
    );

    if (!mounted || topic == null) return;
    setState(() {
      if (topic == '__clear__') {
        _selectedTopic = null;
        _minRating = null;
        _selectedLevel = 'all';
      } else {
        final parts = topic.split('|');
        _selectedTopic = parts[0].isEmpty ? null : parts[0];
        _minRating = parts[1].isEmpty ? null : double.parse(parts[1]);
        _selectedLevel = parts[2].isEmpty ? 'all' : parts[2];
      }
    });
  }

  List<SearchCourseData> get _filteredCourses {
    final keyword = _searchController.text.trim().toLowerCase();
    final result = searchCourses.where((course) {
      final searchableText = '${course.title} ${course.category}'.toLowerCase();
      final matchLevel = _selectedLevel == 'all' || course.level == _selectedLevel;
      final matchTopic = _selectedTopic == null || course.category.toLowerCase() == _selectedTopic!.toLowerCase();
      final matchRating = _minRating == null || course.rating >= _minRating!;
      return searchableText.contains(keyword) && matchLevel && matchTopic && matchRating;
    }).toList();

    switch (_selectedSort) {
      case 'price-low':
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price-high':
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        break;
    }

    return result;
  }
}

class _SearchFilterSheet extends StatefulWidget {
  const _SearchFilterSheet({required this.initialTopic, required this.initialRating, required this.initialLevel});

  final String? initialTopic;
  final double? initialRating;
  final String initialLevel;

  @override
  State<_SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<_SearchFilterSheet> {
  static const ratings = [5.0, 4.5, 4.0, 3.5];
  static const topics = ['Business', 'Finance', 'Graphic Design', 'UX Design', 'Design', 'Website'];
  static const levels = ['all', 'beginner', 'intermediate'];

  String? selectedTopic;
  double? selectedRating;
  String selectedLevel = 'all';

  @override
  void initState() {
    super.initState();
    selectedTopic = widget.initialTopic;
    selectedRating = widget.initialRating;
    selectedLevel = widget.initialLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: const SectionTitle(text: 'Ratings'),
          children: [
            Wrap(
              spacing: 8,
              children: ratings
                  .map((value) => ChoiceChip(
                        label: Text('$value+'),
                        selected: selectedRating == value,
                        onSelected: (_) => setState(() => selectedRating = value),
                      ))
                  .toList(),
            ),
          ],
        ),
        ExpansionTile(
          initiallyExpanded: true,
          title: const SectionTitle(text: 'Topics'),
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: topics
                  .map((topic) => ChoiceChip(
                        label: Text(topic),
                        selected: selectedTopic == topic,
                        onSelected: (_) => setState(() => selectedTopic = topic),
                      ))
                  .toList(),
            ),
          ],
        ),
        ExpansionTile(
          title: const SectionTitle(text: 'Level'),
          children: levels
              .map(
                (level) => CustomRadioTile<String>(
                  option: level,
                  selectedOption: selectedLevel,
                  onChanged: (value) => setState(() => selectedLevel = value),
                  title: BodyTitle(text: level[0].toUpperCase() + level.substring(1)),
                ),
              )
              .toList(),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop('__clear__'),
                child: const Text('Clear'),
              ),
            ),
            SizedBox(width: AppWidth.w8),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: () => Navigator.of(context).pop('${selectedTopic ?? ''}|${selectedRating?.toString() ?? ''}|$selectedLevel'),
                child: const Text('Apply Filter'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
