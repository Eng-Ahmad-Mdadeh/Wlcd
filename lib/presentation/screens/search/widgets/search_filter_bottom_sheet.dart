import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/domain/entity/catalog/course_filters/course_filters_entity.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/presentation/bloc/catalog/course_filters/course_filters_bloc.dart';

enum SearchFilterSheetMode { filters, sort, difficulty }

abstract final class _FilterSheetColors {
  static const background = Color(0xFFF8F9FC);
  static const title = Color(0xFF171B2C);
  static const muted = Color(0xFF7B8191);
  static const border = Color(0xFFE8EAF0);
  static const control = Color(0xFFF0F2F6);
  static const chip = Color(0xFFF1F3F7);
  static const selectedChip = Color(0xFF1F275D);
}

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
        decoration: const BoxDecoration(
          color: _FilterSheetColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            const _Handle(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 12, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(_headerIcon, color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _title,
                          style: const TextStyle(
                            color: _FilterSheetColors.title,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _subtitle,
                          style: const TextStyle(
                            color: _FilterSheetColors.muted,
                            fontSize: 12.5,
                            height: 1.35,
                          ),
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
                      child: const Text('مسح'),
                    ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: _FilterSheetColors.control,
                    ),
                    icon: const Icon(Icons.close_rounded, size: 20),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: _FilterSheetColors.border),
            Expanded(
              child: BlocBuilder<CourseFiltersBloc, ICourseFiltersState>(
                builder: (context, state) {
                  if (state is CourseFiltersLoading || state is CourseFiltersInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CourseFiltersFailed) {
                    return _FilterError(
                      onRetry: () => context.read<CourseFiltersBloc>().add(const LoadCourseFiltersEvent()),
                    );
                  }
                  final filters = (state as CourseFiltersLoaded).filters;
                  if (filters == null) return const Center(child: Text('لا توجد خيارات تصفية متاحة'));
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
    padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
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
                  ButtonSegment(value: null, label: Text('الكل')),
                  ButtonSegment(value: true, label: Text('مجاني')),
                  ButtonSegment(value: false, label: Text('مدفوع')),
                ],
                selected: {_value.isFree},
                onSelectionChanged: (selection) => _update(_value.copyWith(isFree: selection.first)),
                showSelectedIcon: false,
                style: ButtonStyle(
                  visualDensity: VisualDensity.comfortable,
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (max > min) ...[
                const SizedBox(height: 18),
                Row(
                  children: [
                    _PriceValue(
                      label: 'من',
                      value:
                          '${_price!.start.round()} ${filters.priceCurrency}',
                    ),
                    const SizedBox(width: 10),
                    _PriceValue(
                      label: 'إلى',
                      value: '${_price!.end.round()} ${filters.priceCurrency}',
                    ),
                  ],
                ),
                const SizedBox(height: 4),
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
    padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
    children: [section],
  );

  Widget _footer() => SafeArea(
    top: false,
    child: Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _FilterSheetColors.border)),
        boxShadow: [
          BoxShadow(
            color: Color(0x120F172A),
            blurRadius: 18,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: FilledButton.icon(
        onPressed: () {
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
        },
        icon: const Icon(Icons.check_rounded),
        label: Text(
          widget.mode == SearchFilterSheetMode.filters
              ? 'عرض النتائج'
              : 'تطبيق الاختيار',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 44,
      height: 5,
      decoration: BoxDecoration(
        color: const Color(0xFFCDD1DA),
        borderRadius: BorderRadius.circular(20),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _FilterSheetColors.control,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: _FilterSheetColors.muted,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: _FilterSheetColors.title,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
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
    padding: const EdgeInsets.only(bottom: 12),
    child: Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: _FilterSheetColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          maintainState: true,
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
          iconColor: AppColors.primary,
          collapsedIconColor: _FilterSheetColors.muted,
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .07),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: _FilterSheetColors.title,
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          children: [
            const Divider(height: 1, color: _FilterSheetColors.border),
            const SizedBox(height: 14),
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
        if (index != values.length - 1) const SizedBox(height: 8),
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
        : _FilterSheetColors.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: selected
            ? AppColors.primary.withValues(alpha: .28)
            : _FilterSheetColors.border,
      ),
    ),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: selected
                      ? AppColors.primary
                      : _FilterSheetColors.title,
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : _FilterSheetColors.muted,
                ),
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      size: 15,
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
      return ChoiceChip(
        label: Text(option.label),
        selected: isSelected,
        onSelected: (active) => onSelected(active ? option.id : null),
        showCheckmark: false,
        selectedColor: _FilterSheetColors.selectedChip,
        backgroundColor: _FilterSheetColors.chip,
        side: BorderSide(
          color: isSelected
              ? _FilterSheetColors.selectedChip
              : Colors.transparent,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.white : _FilterSheetColors.muted,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
      return FilterChip(
        label: Text(option.label),
        selected: isSelected,
        onSelected: (active) {
          final updated = [...selected];
          active ? updated.add(option.id) : updated.remove(option.id);
          onChanged(updated);
        },
        checkmarkColor: AppColors.white,
        selectedColor: _FilterSheetColors.selectedChip,
        backgroundColor: _FilterSheetColors.chip,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.white : _FilterSheetColors.muted,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
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
      return ChoiceChip(
        label: Text(labels[value] ?? value),
        selected: isSelected,
        onSelected: (active) => onSelected(active ? value : null),
        showCheckmark: false,
        avatar: isSelected
            ? const Icon(Icons.check_rounded, size: 17, color: AppColors.white)
            : null,
        selectedColor: _FilterSheetColors.selectedChip,
        backgroundColor: _FilterSheetColors.chip,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.white : _FilterSheetColors.muted,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
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
        const Icon(Icons.cloud_off_rounded, size: 44, color: AppColors.greyText),
        const SizedBox(height: 12),
        const Text('تعذر تحميل خيارات التصفية'),
        TextButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh_rounded), label: const Text('إعادة المحاولة')),
      ],
    ),
  );
}
