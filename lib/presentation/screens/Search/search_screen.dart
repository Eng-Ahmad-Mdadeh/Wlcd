import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/search/search_cubit.dart';
import 'package:wlcd/presentation/cubit/search/search_state.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_filter_sheet.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_results_header.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_results_view.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_top_filters.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/custom_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  static const List<String> _sortItems = ['default', 'price-low', 'price-high', 'rating'];
  static const List<String> _levelItems = ['all', 'beginner', 'intermediate'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final cubit = context.read<SearchCubit>();
          final filteredCourses = state.filteredCourses;
          return Scaffold(
            backgroundColor: const Color(0xfff3f4f6),
            appBar: const CustomAppBar(title: 'Search Course', showBackButton: true),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchTopFilters(
                      searchController: cubit.searchController,
                      onSearchChanged: cubit.onKeywordChanged,
                      onOpenFilter: () => _openFilterSheet(context, state),
                      sortItems: _sortItems,
                      levelItems: _levelItems,
                      selectedSort: state.sort,
                      selectedLevel: state.level,
                      onSortChanged: cubit.onSortChanged,
                      onLevelChanged: cubit.onLevelChanged,
                    ),
                    SizedBox(height: AppHeight.h12),
                    SearchResultsHeader(count: filteredCourses.length, tabController: _tabController),
                    SizedBox(height: AppHeight.h12),
                    Expanded(child: SearchResultsView(courses: filteredCourses, tabController: _tabController)),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _BottomBarMock(),
          );
        },
      ),
    );
  }

  Future<void> _openFilterSheet(BuildContext context, SearchState state) async {
     await CustomBottomSheet.show(
      context,
      title: 'Filter',
      heightFactor: .8,
      isScroll: false,
      body: SearchFilterSheet(initialTopic: state.topic, initialRating: state.minRating, initialLevel: state.level),
    );

    if (!context.mounted ) return;
    final cubit = context.read<SearchCubit>();
    // if (result.clear) {
    //   cubit.clearFilter();
    // } else {
    //   cubit.applyFilter(topic: result.topic, rating: result.rating, level: result.level);
    // }
  }
}

class _BottomBarMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, -2))],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _NavItem(label: 'Home', icon: Icons.home_outlined),
                _NavItem(label: 'Explore', icon: Icons.explore_outlined, active: true),
                SizedBox(width: 50),
                _NavItem(label: 'Wishlist', icon: Icons.bookmark_border),
                _NavItem(label: 'Profile', icon: Icons.person_outline),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 4,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(99)),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.label, required this.icon, this.active = false});
  final String label;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : const Color(0xff9ca3af);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: color, fontWeight: active ? FontWeight.w700 : FontWeight.w400),
        ),
      ],
    );
  }
}
