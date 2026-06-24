import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LearningInterestsWidget extends StatefulWidget {
  const LearningInterestsWidget({super.key});

  @override
  State<LearningInterestsWidget> createState() => _LearningInterestsWidgetState();
}

class _LearningInterestsWidgetState extends State<LearningInterestsWidget> {
  final Set<String> _selectedInterests = {'تطوير الذات', 'البرمجة'};

  static const List<_InterestOption> _interests = [
    _InterestOption(title: 'البرمجة', icon: Icons.code_rounded, color: Color(0xFF3B82F6)),
    _InterestOption(title: 'التصميم', icon: Icons.palette_rounded, color: Color(0xFF8B5CF6)),
    _InterestOption(title: 'اللغات', icon: Icons.translate_rounded, color: Color(0xFF14B8A6)),
    _InterestOption(title: 'الأعمال', icon: Icons.business_center_rounded, color: Color(0xFFF59E0B)),
    _InterestOption(title: 'التسويق', icon: Icons.campaign_rounded, color: Color(0xFFEF4444)),
    _InterestOption(title: 'تطوير الذات', icon: Icons.psychology_rounded, color: Color(0xFF22C55E)),
  ];

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
          Wrap(spacing: AppWidth.w10, runSpacing: AppHeight.h10, children: _interests.map(_buildInterestChip).toList()),
          SizedBox(height: AppHeight.h18),
          _buildFooter(),
        ],
      ),
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
                'اهتماماتك التعليمية',
                style: TextStyle(color: AppColors.text, fontSize: AppFontSize.s17, fontWeight: AppFontWeight.bold),
              ),
              SizedBox(height: AppHeight.h4),
              Text(
                'اختر المجالات التي تهمك لنقترح لك محتوى يناسب أهدافك.',
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

  Widget _buildInterestChip(_InterestOption interest) {
    final bool isSelected = _selectedInterests.contains(interest.title);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: InkWell(
        onTap: () => _toggleInterest(interest.title),
        borderRadius: BorderRadius.circular(AppRadius.r100),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12, vertical: AppPaddingHeight.p10),
          decoration: BoxDecoration(
            color: isSelected ? interest.color.withOpacity(0.12) : AppColors.greyButton,
            borderRadius: BorderRadius.circular(AppRadius.r100),
            border: Border.all(color: isSelected ? interest.color : AppColors.notificationBorder, width: AppWidth.w1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(interest.icon, color: isSelected ? interest.color : AppColors.profileIcon, size: AppSize.s18),
              SizedBox(width: AppWidth.w6),
              SectionTitle(
                text: interest.title,
                color: isSelected ? AppColors.text : AppColors.seeMore,
                fontSize: AppFontSize.s13,
                fontWeight: isSelected ? AppFontWeight.bold : AppFontWeight.medium,
              ),
              if (isSelected) ...[
                SizedBox(width: AppWidth.w6),
                Icon(Icons.check_circle_rounded, color: interest.color, size: AppSize.s16),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
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
              text: 'تم اختيار ${_selectedInterests.length} مجالات — يمكنك تعديلها في أي وقت لتحسين تجربة التعلم.',
              color: AppColors.seeMore,
              fontSize: AppFontSize.s12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }
}

class _InterestOption {
  const _InterestOption({required this.title, required this.icon, required this.color});

  final String title;
  final IconData icon;
  final Color color;
}
