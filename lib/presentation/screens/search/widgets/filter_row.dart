import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/presentation/bloc/catalog/course_filters/course_filters_bloc.dart';
import 'package:wlcd/presentation/bloc/catalog/courses/courses_bloc.dart';
import 'package:wlcd/presentation/cubit/catalog/courses_query_cubit.dart';
import 'package:wlcd/presentation/screens/search/widgets/search_filter_bottom_sheet.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key});

  Future<void> _showFilters(
    BuildContext context,
    SearchFilterSheetMode mode,
  ) async {
    final queryCubit = context.read<CoursesQueryCubit>();
    final filtersBloc = context.read<CourseFiltersBloc>();
    final result = await showModalBottomSheet<GetCoursesEntity>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: filtersBloc,
        child: SearchFilterBottomSheet(
          initialValue: queryCubit.state,
          mode: mode,
        ),
      ),
    );
    if (result == null || !context.mounted) return;

    queryCubit.setFilters(result);
    context.read<CoursesBloc>().add(LoadCoursesEvent(queryCubit.state));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesQueryCubit, GetCoursesEntity>(
      builder: (context, query) {
        final count = _activeFilterCount(query);
        return Row(
          children: [
            Expanded(
              child: _FilterBox(
                onTap: () => _showFilters(
                  context,
                  SearchFilterSheetMode.filters,
                ),
                isActive: count > 0,
                icon: Icons.tune_rounded,
                label: count == 0 ? 'تصفية' : 'تصفية ($count)',
              ),
            ),
            SizedBox(width: AppWidth.w5),
            Expanded(
              child: _FilterBox(
                onTap: () => _showFilters(
                  context,
                  SearchFilterSheetMode.sort,
                ),
                isActive: query.sort != null,
                icon: Icons.swap_vert_rounded,
                label: _sortLabel(query.sort),
              ),
            ),
            SizedBox(width: AppWidth.w5),
            Expanded(
              child: _FilterBox(
                onTap: () => _showFilters(
                  context,
                  SearchFilterSheetMode.difficulty,
                ),
                isActive: query.difficulty != null,
                icon: Icons.signal_cellular_alt_rounded,
                label: _difficultyLabel(query.difficulty),
              ),
            ),
          ],
        );
      },
    );
  }

  int _activeFilterCount(GetCoursesEntity value) => [
    value.categoryId,
    if (value.tagIds.isNotEmpty) value.tagIds,
    value.language,
    value.isFree,
    value.priceMin,
    value.priceMax,
    value.currency,
  ].where((item) => item != null).length;

  String _sortLabel(String? value) => switch (value) {
    '-publishedAt' => 'الأحدث',
    'publishedAt' => 'الأقدم',
    'title' => 'العنوان أ-ي',
    '-title' => 'العنوان ي-أ',
    _ => 'الترتيب',
  };

  String _difficultyLabel(String? value) => switch (value) {
    'beginner' => 'مبتدئ',
    'intermediate' => 'متوسط',
    'advanced' => 'متقدم',
    _ => 'كل المستويات',
  };
}

class _FilterBox extends StatelessWidget {
  const _FilterBox({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isActive,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.greyText;
    return Material(
      color: isActive ? AppColors.primary.withValues(alpha: .08) : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isActive ? AppColors.primary.withValues(alpha: .35) : AppColors.searchFilterBorder,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: AppHeight.h38,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: AppSize.s16, color: color),
                SizedBox(width: AppWidth.w5),
                Flexible(
                  child: BodyTitle(
                    text: label,
                    fontSize: AppFontSize.s13,
                    color: color,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
