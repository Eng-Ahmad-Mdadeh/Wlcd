import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_elevated_button.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class SearchFilterBottomSheet extends StatelessWidget {
  const SearchFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: AppPaddingHeight.p10),
            width: AppWidth.w48,
            height: AppHeight.h5,
            decoration: BoxDecoration(
              color: const Color(0xFFD7D8DD),
              borderRadius: BorderRadius.circular(AppRadius.r35),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: AppPaddingWidth.p18,
              end: AppPaddingWidth.p18,
              top: AppPaddingHeight.p20,
              bottom: AppPaddingHeight.p16,
            ),
            child: Row(
              children: [
                const BodyTitle(
                  text: 'Filter',
                  fontSize: AppFontSize.s20,
                  color: AppColors.black,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const BodyTitle(
                    text: 'Cancel',
                    fontSize: AppFontSize.s15,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE8E9EE)),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(
                start: AppPaddingWidth.p18,
                end: AppPaddingWidth.p18,
                top: AppPaddingHeight.p16,
              ),
              child: const Column(
                children: [
                  _BottomSheetTile(title: 'Ratings', icon: Icons.star_border_rounded),
                  SizedBox(height: 12),
                  _TopicsBox(),
                  SizedBox(height: 12),
                  _BottomSheetTile(title: 'Level', icon: Icons.tune),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                AppPaddingWidth.p18,
                AppPaddingHeight.p10,
                AppPaddingWidth.p18,
                AppPaddingHeight.p16,
              ),
              child: CustomElevatedButton(
                borderRadius: 28,
                height: 56,
                width: double.infinity,
                color: AppColors.primary,
                onPressed: () => Navigator.pop(context),
                child: const BodyTitle(
                  text: 'Apply Filter',
                  color: AppColors.white,
                  fontSize: AppFontSize.s17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheetTile extends StatelessWidget {
  const _BottomSheetTile({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E6EA)),
      ),
      child: Row(
        children: [
          Icon(icon, size: AppSize.s18, color: AppColors.black),
          SizedBox(width: AppWidth.w10),
          BodyTitle(
            text: title,
            fontSize: AppFontSize.s16,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.greyText),
        ],
      ),
    );
  }
}

class _TopicsBox extends StatelessWidget {
  const _TopicsBox();

  @override
  Widget build(BuildContext context) {
    const List<String> topics = [
      'Business',
      'Finance',
      'Graphic Design',
      'UX Design',
      'Design',
      'Website',
      'Cryptocurrency',
      'Digitalization',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E6EA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.grid_view_rounded, size: AppSize.s18, color: AppColors.black),
              SizedBox(width: 10),
              BodyTitle(
                text: 'Topics',
                fontSize: AppFontSize.s16,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_up_rounded, color: AppColors.greyText),
            ],
          ),
          SizedBox(height: AppPaddingHeight.p12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: topics
                .map(
                  (topic) => Chip(
                    label: Text(topic),
                    labelStyle: TextStyle(
                      color: topic == 'Finance' ? AppColors.white : AppColors.greyText,
                      fontSize: AppFontSize.s13,
                    ),
                    backgroundColor:
                        topic == 'Finance' ? AppColors.primary : const Color(0xFFF3F4F7),
                    side: BorderSide.none,
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
