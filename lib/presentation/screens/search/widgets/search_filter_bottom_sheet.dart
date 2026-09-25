import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/domain/entity/catalog/course_filters/course_filters_entity.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/presentation/bloc/catalog/course_filters/course_filters_bloc.dart';

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
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            const _Handle(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                children: [
                  Text(
                    _title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  if (_showReset)
                    TextButton(
                      onPressed: _resetCurrentSection,
                      child: const Text('مسح'),
                    ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                ],
              ),
            ),
            const Divider(height: 1),
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
          child: _StringChoices(
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
          child: _StringChoices(
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
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
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
              ),
              if (max > min) ...[
                const SizedBox(height: 14),
                Row(children: [Text('${_price!.start.round()} ${filters.priceCurrency}'), const Spacer(), Text('${_price!.end.round()} ${filters.priceCurrency}')]),
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
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
    children: [section],
  );

  Widget _footer() => SafeArea(
    top: false,
    child: Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.searchFilterBorder)),
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
        label: const Text('عرض النتائج', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54), backgroundColor: AppColors.primary),
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
      decoration: BoxDecoration(color: const Color(0xFFD7D8DD), borderRadius: BorderRadius.circular(20)),
    ),
  );
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.icon, required this.child});
  final String title;
  final IconData icon;
  final Widget child;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Icon(icon, size: 20, color: AppColors.primary), const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))]),
        const SizedBox(height: 12),
        child,
      ],
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
    children: options.map((option) => ChoiceChip(
      label: Text(option.label),
      selected: selected == option.id,
      onSelected: (active) => onSelected(active ? option.id : null),
    )).toList(),
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
    children: options.map((option) => FilterChip(
      label: Text(option.label),
      selected: selected.contains(option.id),
      onSelected: (active) {
        final updated = [...selected];
        active ? updated.add(option.id) : updated.remove(option.id);
        onChanged(updated);
      },
    )).toList(),
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
    children: values.map((value) => ChoiceChip(
      label: Text(labels[value] ?? value),
      selected: selected == value,
      onSelected: (active) => onSelected(active ? value : null),
    )).toList(),
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
