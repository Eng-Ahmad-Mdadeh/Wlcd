import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/domain/entity/catalog/course_filters/course_filters_entity.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/presentation/bloc/catalog/course_filters/course_filters_bloc.dart';
import 'package:wlcd/presentation/widgets/custom_elevated_button.dart';
import 'package:wlcd/presentation/widgets/custom_filter_chip.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/page_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

enum SearchFilterSheetMode { filters, sort, difficulty }

class SearchFilterBottomSheet extends StatefulWidget {
  const SearchFilterBottomSheet({
    required this.initialValue,
    this.mode = SearchFilterSheetMode.filters,
    super.key,
  });

  final GetCoursesEntity initialValue;
  final SearchFilterSheetMode mode;

  @override
  State<SearchFilterBottomSheet> createState() => _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  late GetCoursesEntity _value = widget.initialValue;
  RangeValues? _price;
  bool _priceChanged = false;
  String? _priceCurrency;

  void _update(GetCoursesEntity value) => setState(() => _value = value);

  String get _title => switch (widget.mode) {
    SearchFilterSheetMode.filters => 'تصفية الكورسات',
    SearchFilterSheetMode.sort => 'ترتيب النتائج',
    SearchFilterSheetMode.difficulty => 'المستوى',
  };

  String get _subtitle => switch (widget.mode) {
    SearchFilterSheetMode.filters =>
      'خصص النتائج حسب اهتماماتك وميزانيتك',
    SearchFilterSheetMode.sort => 'اختر الطريقة الأنسب لعرض الكورسات',
    SearchFilterSheetMode.difficulty =>
      'اختر المستوى المتوافق مع خبرتك الحالية',
  };

  IconData get _headerIcon => switch (widget.mode) {
    SearchFilterSheetMode.filters => Icons.tune_rounded,
    SearchFilterSheetMode.sort => Icons.swap_vert_rounded,
    SearchFilterSheetMode.difficulty => Icons.signal_cellular_alt_rounded,
  };

  bool get _showReset => switch (widget.mode) {
    SearchFilterSheetMode.filters => _hasGeneralFilters,
    SearchFilterSheetMode.sort => _value.sort != null,
    SearchFilterSheetMode.difficulty => _value.difficulty != null,
  };

  bool get _hasGeneralFilters =>
      _value.categoryId != null ||
      _value.tagIds.isNotEmpty ||
      _value.language != null ||
      _value.isFree != null ||
      _value.priceMin != null ||
      _value.priceMax != null;

  double get _heightFactor => switch (widget.mode) {
    SearchFilterSheetMode.filters => .9,
    SearchFilterSheetMode.sort || SearchFilterSheetMode.difficulty => .48,
  };

  void _resetCurrentSection() {
    setState(() {
      _value = switch (widget.mode) {
        SearchFilterSheetMode.filters => _value.copyWith(
          categoryId: null,
          tagIds: const [],
          language: null,
          isFree: null,
          priceMin: null,
          priceMax: null,
          currency: null,
        ),
        SearchFilterSheetMode.sort => _value.copyWith(sort: null),
        SearchFilterSheetMode.difficulty => _value.copyWith(difficulty: null),
      };
      if (widget.mode == SearchFilterSheetMode.filters) {
        _price = null;
        _priceChanged = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * _heightFactor,
        ),
        decoration: BoxDecoration(
          color: AppColors.searchFilterBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.r28),
          ),
        ),
        child: Column(
          children: [
            const _Handle(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                AppPaddingWidth.p20,
                AppPaddingHeight.p4,
                AppPaddingWidth.p12,
                AppPaddingHeight.p18,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: AppWidth.w45,
                    height: AppHeight.h45,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(AppRadius.r14),
                    ),
                    child: Icon(
                      _headerIcon,
                      color: AppColors.primary,
                      size: AppSize.s22,
                    ),
                  ),
                  SizedBox(width: AppWidth.w12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageTitle(
                          text: _title,
                          textAlign: TextAlign.start,
                          color: AppColors.searchFilterTitle,
                          fontSize: AppFontSize.s20,
                          fontWeight: AppFontWeight.bold,
                          height: 1.3,
                        ),
                        SizedBox(height: AppHeight.h3),
                        BodyTitle(
                          text: _subtitle,
                          color: AppColors.searchFilterMuted,
                          fontSize: AppFontSize.s13,
                          fontWeight: AppFontWeight.regular,
                          height: 1.35,
                        ),
                      ],
                    ),
                  ),
                  if (_showReset)
                    TextButton(
                      onPressed: _resetCurrentSection,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.danger,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const BodyTitle(
                        text: 'مسح',
                        color: AppColors.danger,
                      ),
                    ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.searchFilterControl,
                    ),
                    icon: Icon(Icons.close_rounded, size: AppSize.s20),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.searchFilterBorder),
            Expanded(
              child: BlocBuilder<CourseFiltersBloc, ICourseFiltersState>(
                builder: (context, state) {
                  if (state is CourseFiltersLoading || state is CourseFiltersInitial) {
                    return LoadingWidget2(
                      0,
                      size: AppSize.s35,
                      color: AppColors.primary,
                    );
                  }
                  if (state is CourseFiltersFailed) {
                    return _FilterError(
                      onRetry: () => context.read<CourseFiltersBloc>().add(const LoadCourseFiltersEvent()),
                    );
                  }
                  final filters = (state as CourseFiltersLoaded).filters;
                  if (filters == null) {
                    return const Center(
                      child: BodyTitle(
                        text: 'لا توجد خيارات تصفية متاحة',
                        color: AppColors.searchFilterMuted,
                      ),
                    );
                  }
                  return _content(filters);
                },
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _content(CourseFiltersModel filters) {
    if (widget.mode == SearchFilterSheetMode.sort) {
      return _singleSectionContent(
        _Section(
          title: 'ترتيب النتائج',
          icon: Icons.swap_vert_rounded,
          initiallyExpanded: true,
          child: _SelectionList(
            values: filters.sortOptions,
            selected: _value.sort,
            labels: const {
              '-publishedAt': 'الأحدث',
              'publishedAt': 'الأقدم',
              'title': 'العنوان أ-ي',
              '-title': 'العنوان ي-أ',
            },
            onSelected: (value) => _update(_value.copyWith(sort: value)),
          ),
        ),
      );
    }

    if (widget.mode == SearchFilterSheetMode.difficulty) {
      return _singleSectionContent(
        _Section(
          title: 'اختر المستوى المناسب',
          icon: Icons.signal_cellular_alt_rounded,
          initiallyExpanded: true,
          child: _SelectionList(
            values: filters.difficulties,
            selected: _value.difficulty,
            labels: const {
              'beginner': 'مبتدئ',
              'intermediate': 'متوسط',
              'advanced': 'متقدم',
            },
            onSelected: (value) =>
                _update(_value.copyWith(difficulty: value)),
          ),
        ),
      );
    }

    _priceCurrency = filters.priceCurrency;
    final min = double.tryParse(filters.priceMin) ?? 0;
    final max = double.tryParse(filters.priceMax) ?? min;
    final initialStart = (_value.priceMin?.toDouble() ?? min).clamp(min, max).toDouble();
    final initialEnd = (_value.priceMax?.toDouble() ?? max).clamp(initialStart, max).toDouble();
    _price ??= RangeValues(initialStart, initialEnd);

    return ListView(
    padding: EdgeInsetsDirectional.fromSTEB(
      AppPaddingWidth.p18,
      AppPaddingHeight.p18,
      AppPaddingWidth.p18,
      AppHeight.h28,
    ),
      children: [
        _Section(
          title: 'التصنيف',
          icon: Icons.category_outlined,
          child: _SingleChoiceWrap(
            options: filters.categories,
            selected: _value.categoryId,
            onSelected: (id) => _update(_value.copyWith(categoryId: id)),
          ),
        ),
        _Section(
          title: 'المواضيع والمهارات',
          icon: Icons.local_offer_outlined,
          initiallyExpanded: true,
          child: _MultiChoiceWrap(
            options: filters.tags,
            selected: _value.tagIds,
            onChanged: (tags) => _update(_value.copyWith(tagIds: tags)),
          ),
        ),
        _Section(
          title: 'السعر',
          icon: Icons.payments_outlined,
          child: Column(
            children: [
              SegmentedButton<bool?>(
                segments: const [
                  ButtonSegment(
                    value: null,
                    label: BodyTitle(text: 'الكل'),
                  ),
                  ButtonSegment(
                    value: true,
                    label: BodyTitle(text: 'مجاني'),
                  ),
                  ButtonSegment(
                    value: false,
                    label: BodyTitle(text: 'مدفوع'),
                  ),
                ],
                selected: {_value.isFree},
                onSelectionChanged: (selection) => _update(_value.copyWith(isFree: selection.first)),
                showSelectedIcon: false,
                style: ButtonStyle(
                  visualDensity: VisualDensity.comfortable,
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r10),
                    ),
                  ),
                ),
              ),
              if (max > min) ...[
                SizedBox(height: AppHeight.h18),
                Row(
                  children: [
                    _PriceValue(
                      label: 'من',
                      value:
                          '${_price!.start.round()} ${filters.priceCurrency}',
                    ),
                    SizedBox(width: AppWidth.w10),
                    _PriceValue(
                      label: 'إلى',
                      value: '${_price!.end.round()} ${filters.priceCurrency}',
                    ),
                  ],
                ),
                SizedBox(height: AppHeight.h4),
                RangeSlider(
                  min: min,
                  max: max,
                  values: _price!,
                  labels: RangeLabels(_price!.start.round().toString(), _price!.end.round().toString()),
                  onChanged: (value) => setState(() {
                    _price = value;
                    _priceChanged = true;
                  }),
                ),
              ],
            ],
          ),
        ),
        if (filters.languages.isNotEmpty)
          _Section(
            title: 'اللغة',
            icon: Icons.language_rounded,
            child: _StringChoices(
              values: filters.languages,
              selected: _value.language,
              labels: const {'ar': 'العربية', 'en': 'الإنجليزية'},
              onSelected: (value) => _update(_value.copyWith(language: value)),
            ),
          ),
      ],
    );
  }

  Widget _singleSectionContent(Widget section) => ListView(
    padding: EdgeInsetsDirectional.fromSTEB(
      AppPaddingWidth.p18,
      AppPaddingHeight.p18,
      AppPaddingWidth.p18,
      AppPaddingHeight.p24,
    ),
    children: [section],
  );

  void _apply() {
    final price = _price;
    final shouldApplyPrice = widget.mode == SearchFilterSheetMode.filters &&
        (_priceChanged ||
            _value.priceMin != null ||
            _value.priceMax != null);
    final result = price == null || !shouldApplyPrice
        ? _value
        : _value.copyWith(
            priceMin: price.start,
            priceMax: price.end,
            currency: _value.currency ?? _priceCurrency,
          );
    Navigator.pop(context, result);
  }

  Widget _footer() => SafeArea(
    top: false,
    child: Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppPaddingWidth.p20,
        AppPaddingHeight.p12,
        AppPaddingWidth.p20,
        AppPaddingHeight.p16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.searchFilterBorder)),
        boxShadow: [
          BoxShadow(
            color: Color(0x120F172A),
            blurRadius: 18,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: CustomElevatedButton(
        borderRadius: AppRadius.r16,
        height: AppHeight.h55,
        width: double.infinity,
        color: AppColors.primary,
        elevation: 0,
        onPressed: _apply,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_rounded, color: AppColors.white),
            SizedBox(width: AppWidth.w8),
            BodyTitle(
              text: widget.mode == SearchFilterSheetMode.filters
                  ? 'عرض النتائج'
                  : 'تطبيق الاختيار',
              color: AppColors.white,
              fontSize: AppFontSize.s16,
              fontWeight: AppFontWeight.bold,
            ),
          ],
        ),
      ),
    ),
  );
}

class _Handle extends StatelessWidget {
  const _Handle();
  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: AppMarginHeight.m10),
      width: AppWidth.w45,
      height: AppHeight.h5,
      decoration: BoxDecoration(
        color: const Color(0xFFCDD1DA),
        borderRadius: BorderRadius.circular(AppRadius.r20),
      ),
    ),
  );
}

class _PriceValue extends StatelessWidget {
  const _PriceValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPaddingWidth.p12,
        vertical: AppPaddingHeight.p10,
      ),
      decoration: BoxDecoration(
        color: AppColors.searchFilterControl,
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Row(
        children: [
          BodyTitle(
            text: label,
            color: AppColors.searchFilterMuted,
            fontSize: AppFontSize.s12,
            fontWeight: AppFontWeight.regular,
          ),
          const Spacer(),
          BodyTitle(
            text: value,
            color: AppColors.searchFilterTitle,
            fontSize: AppFontSize.s13,
            fontWeight: AppFontWeight.bold,
          ),
        ],
      ),
    ),
  );
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.icon,
    required this.child,
    this.initiallyExpanded = false,
  });
  final String title;
  final IconData icon;
  final Widget child;
  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: AppPaddingHeight.p12),
    child: Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        side: const BorderSide(color: AppColors.searchFilterBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          maintainState: true,
          tilePadding: EdgeInsets.symmetric(
            horizontal: AppPaddingWidth.p14,
            vertical: AppPaddingHeight.p4,
          ),
          childrenPadding: EdgeInsetsDirectional.fromSTEB(
            AppPaddingWidth.p14,
            0,
            AppPaddingWidth.p14,
            AppPaddingHeight.p16,
          ),
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.searchFilterMuted,
          leading: Container(
            width: AppWidth.w35,
            height: AppHeight.h35,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .07),
              borderRadius: BorderRadius.circular(AppRadius.r10),
            ),
            child: Icon(
              icon,
              size: AppSize.s18,
              color: AppColors.primary,
            ),
          ),
          title: SectionTitle(
            text: title,
            color: AppColors.searchFilterTitle,
            fontSize: AppFontSize.s16,
            fontWeight: AppFontWeight.bold,
          ),
          children: [
            const Divider(height: 1, color: AppColors.searchFilterBorder),
            SizedBox(height: AppHeight.h14),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: child,
            ),
          ],
        ),
      ),
    ),
  );
}

class _SelectionList extends StatelessWidget {
  const _SelectionList({
    required this.values,
    required this.selected,
    required this.labels,
    required this.onSelected,
  });

  final List<String> values;
  final String? selected;
  final Map<String, String> labels;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var index = 0; index < values.length; index++) ...[
        _SelectionTile(
          label: labels[values[index]] ?? values[index],
          selected: selected == values[index],
          onTap: () => onSelected(
            selected == values[index] ? null : values[index],
          ),
        ),
        if (index != values.length - 1) SizedBox(height: AppHeight.h8),
      ],
    ],
  );
}

class _SelectionTile extends StatelessWidget {
  const _SelectionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: selected
        ? AppColors.primary.withValues(alpha: .07)
        : AppColors.searchFilterBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.r12),
      side: BorderSide(
        color: selected
            ? AppColors.primary.withValues(alpha: .28)
            : AppColors.searchFilterBorder,
      ),
    ),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddingWidth.p14,
          vertical: AppPaddingHeight.p13,
        ),
        child: Row(
          children: [
            Expanded(
              child: BodyTitle(
                text: label,
                color: selected
                    ? AppColors.primary
                    : AppColors.searchFilterTitle,
                fontSize: AppFontSize.s14,
                fontWeight: selected
                    ? AppFontWeight.bold
                    : AppFontWeight.medium,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: AppWidth.w22,
              height: AppHeight.h22,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.searchFilterMuted,
                ),
              ),
              child: selected
                  ? Icon(
                      Icons.check_rounded,
                      size: AppSize.s15,
                      color: AppColors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    ),
  );
}

class _SingleChoiceWrap extends StatelessWidget {
  const _SingleChoiceWrap({required this.options, required this.selected, required this.onSelected});
  final List<FilterOptionEntity> options;
  final String? selected;
  final ValueChanged<String?> onSelected;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: options.map((option) {
      final isSelected = selected == option.id;
      return CustomFilterChip(
        text: option.label,
        selected: isSelected,
        onSelected: (active) => onSelected(active ? option.id : null),
        showCheckmark: false,
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.searchFilterChip,
        textColor: AppColors.searchFilterMuted,
        selectedTextColor: AppColors.white,
        fontSize: AppFontSize.s13,
        borderRadius: AppRadius.r10,
        side: BorderSide(
          color: isSelected
              ? AppColors.primary
              : Colors.transparent,
        ),
      );
    }).toList(),
  );
}

class _MultiChoiceWrap extends StatelessWidget {
  const _MultiChoiceWrap({required this.options, required this.selected, required this.onChanged});
  final List<FilterOptionEntity> options;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: options.map((option) {
      final isSelected = selected.contains(option.id);
      return CustomFilterChip(
        text: option.label,
        selected: isSelected,
        onSelected: (active) {
          final updated = [...selected];
          active ? updated.add(option.id) : updated.remove(option.id);
          onChanged(updated);
        },
        showCheckmark: true,
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.searchFilterChip,
        textColor: AppColors.searchFilterMuted,
        selectedTextColor: AppColors.white,
        fontSize: AppFontSize.s13,
        borderRadius: AppRadius.r10,
        side: BorderSide.none,
      );
    }).toList(),
  );
}

class _StringChoices extends StatelessWidget {
  const _StringChoices({required this.values, required this.selected, required this.labels, required this.onSelected});
  final List<String> values;
  final String? selected;
  final Map<String, String> labels;
  final ValueChanged<String?> onSelected;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: values.map((value) {
      final isSelected = selected == value;
      return CustomFilterChip(
        text: labels[value] ?? value,
        selected: isSelected,
        onSelected: (active) => onSelected(active ? value : null),
        showCheckmark: true,
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.searchFilterChip,
        textColor: AppColors.searchFilterMuted,
        selectedTextColor: AppColors.white,
        fontSize: AppFontSize.s13,
        borderRadius: AppRadius.r10,
        side: BorderSide.none,
      );
    }).toList(),
  );
}

class _FilterError extends StatelessWidget {
  const _FilterError({required this.onRetry});
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.cloud_off_rounded,
          size: AppSize.s42,
          color: AppColors.greyText,
        ),
        SizedBox(height: AppHeight.h12),
        const BodyTitle(
          text: 'تعذر تحميل خيارات التصفية',
          color: AppColors.searchFilterTitle,
        ),
        TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded),
          label: const BodyTitle(
            text: 'إعادة المحاولة',
            color: AppColors.primary,
          ),
        ),
      ],
    ),
  );
}
