import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/catalog/category/category_model.dart';
import 'package:wlcd/presentation/bloc/catalog/categories/categories_bloc.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LearningInterestsWidget extends StatelessWidget {
  const LearningInterestsWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => CategoriesBloc()..add(const LoadCategoriesEvent()),
    child: const _LearningInterestsContent(),
  );
}

class _LearningInterestsContent extends StatefulWidget {
  const _LearningInterestsContent();

  @override
  State<_LearningInterestsContent> createState() => _LearningInterestsContentState();
}

class _LearningInterestsContentState extends State<_LearningInterestsContent> {
  final Map<String, bool> _selectionOverrides = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppMarginHeight.m20),
      padding: EdgeInsets.all(AppPaddingWidth.p16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r13),
        border: Border.all(color: AppColors.notificationBorder, width: AppWidth.w1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: AppRadius.r24,
            offset: Offset(0, AppHeight.h12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: AppHeight.h16),
          BlocBuilder<CategoriesBloc, ICategoriesState>(builder: _buildCategories),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context, ICategoriesState state) {
    if (state is CategoriesFailed) {
      return SizedBox(
        height: AppHeight.h100,
        child: RetryWidget(
          onReload: () => context.read<CategoriesBloc>().add(const LoadCategoriesEvent()),
        ),
      );
    }
    if (state is! CategoriesLoaded) {
      return SizedBox(height: AppHeight.h100, child: const LoadingWidget(0));
    }

    final categories = state.categories?.categories ?? const <CategoryModel>[];
    if (categories.isEmpty) return const SizedBox.shrink();
    final selectedCount = categories.where(_isSelected).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppWidth.w10,
          runSpacing: AppHeight.h10,
          children: categories.map(_buildInterestChip).toList(),
        ),
        SizedBox(height: AppHeight.h18),
        _buildFooter(selectedCount),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: AppWidth.w48,
          height: AppHeight.h48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1F275D), Color(0xFF1665E7)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(AppRadius.r16),
          ),
          child: Icon(Icons.auto_awesome_rounded, color: AppColors.white, size: AppSize.s24),
        ),
        SizedBox(width: AppWidth.w12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.learning_interests,
                style: TextStyle(color: AppColors.text, fontSize: AppFontSize.s17, fontWeight: AppFontWeight.bold),
              ),
              SizedBox(height: AppHeight.h4),
              Text(
                context.loc.learning_interests_description,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: AppFontSize.s12,
                  fontWeight: AppFontWeight.regular,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInterestChip(CategoryModel category) {
    final isSelected = _isSelected(category);
    final color = _parseColor(category.color);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: InkWell(
        onTap: () => setState(() => _selectionOverrides[category.categoryId] = !isSelected),
        borderRadius: BorderRadius.circular(AppRadius.r100),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12, vertical: AppPaddingHeight.p10),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.12) : AppColors.greyButton,
            borderRadius: BorderRadius.circular(AppRadius.r100),
            border: Border.all(color: isSelected ? color : AppColors.notificationBorder, width: AppWidth.w1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CategoryIcon(category: category, color: isSelected ? color : AppColors.profileIcon),
              SizedBox(width: AppWidth.w6),
              SectionTitle(
                text: category.label,
                color: isSelected ? AppColors.text : AppColors.seeMore,
                fontSize: AppFontSize.s13,
                fontWeight: isSelected ? AppFontWeight.bold : AppFontWeight.medium,
              ),
              if (isSelected) ...[
                SizedBox(width: AppWidth.w6),
                Icon(Icons.check_circle_rounded, color: color, size: AppSize.s16),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(int selectedCount) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12, vertical: AppPaddingHeight.p12),
      decoration: BoxDecoration(color: AppColors.lightBlue, borderRadius: BorderRadius.circular(AppRadius.r16)),
      child: Row(
        children: [
          Icon(Icons.tips_and_updates_rounded, color: AppColors.accent, size: AppSize.s20),
          SizedBox(width: AppWidth.w10),
          Expanded(
            child: BodyTitle(
              overflow: TextOverflow.visible,
              text: 'تم اختيار $selectedCount مجالات — يمكنك تعديلها في أي وقت لتحسين تجربة التعلم.',
              color: AppColors.seeMore,
              fontSize: AppFontSize.s12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  bool _isSelected(CategoryModel category) => _selectionOverrides[category.categoryId] ?? category.isInterested;

  Color _parseColor(String? hex) {
    final value = hex?.replaceFirst('#', '');
    if (value == null || !RegExp(r'^[0-9a-fA-F]{6}$').hasMatch(value)) return AppColors.accent;
    return Color(int.parse('FF$value', radix: 16));
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.category, required this.color});

  final CategoryModel category;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final iconUrl = category.icon?.url;
    if (iconUrl == null || iconUrl.isEmpty) {
      return Icon(Icons.category_rounded, color: color, size: AppSize.s18);
    }
    return CachedNetworkImage(
      imageUrl: iconUrl,
      width: AppSize.s18,
      height: AppSize.s18,
      fit: BoxFit.contain,
      placeholder: (_, __) => SizedBox(width: AppSize.s18, height: AppSize.s18),
      errorWidget: (_, __, ___) => Icon(Icons.category_rounded, color: color, size: AppSize.s18),
    );
  }
}
