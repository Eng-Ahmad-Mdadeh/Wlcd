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
            backgroundColor: AppColors.backGround,
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
          );
        },
      ),
    );
  }

  Future<void> _openFilterSheet(BuildContext context, SearchState state) async {
    final result = await CustomBottomSheet.show<SearchFilterResult>(
      context,
      title: 'Filter',
      heightFactor: .8,
      isScroll: false,
      body: SearchFilterSheet(initialTopic: state.topic, initialRating: state.minRating, initialLevel: state.level),
    );

    if (!context.mounted || result == null) return;
    final cubit = context.read<SearchCubit>();
    if (result.clear) {
      cubit.clearFilter();
    } else {
      cubit.applyFilter(topic: result.topic, rating: result.rating, level: result.level);
    }
  }
}
