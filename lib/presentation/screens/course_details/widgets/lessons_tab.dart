import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class LessonsTab extends StatelessWidget {
  const LessonsTab({super.key});

  @override
  Widget build(BuildContext context) {
    const lessons = [
      ('Instructor Introduction', '04:00', false),
      ('Design Shortgage', '03:49', false),
      ('Make it Pretty', '03:49', true),
      ('Copy Inspiration', '04:25', true),
      ('Summary', '02:06', true),
    ];

    return ListView(
      key: const PageStorageKey('lessons-tab-scroll'),
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.searchCardBorder),
            borderRadius: BorderRadius.circular(AppRadius.r14),
          ),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: lessons.length + 1,
            separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.searchCardBorder),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: BodyTitle(text: 'Class', fontSize: 16, color: AppColors.searchCardTitle),
                );
              }

              final lesson = lessons[index - 1];
              return ListTile(
                dense: true,
                leading: const Icon(Icons.play_circle_fill, size: 18, color: AppColors.searchRatingText),
                title: BodyTitle(text: lesson.$1, fontSize: 14, color: AppColors.searchCardTitle),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BodyTitle(text: lesson.$2, fontSize: 13, color: AppColors.searchRatingText),
                    if (lesson.$3) ...[
                      SizedBox(width: AppWidth.w6),
                      const Icon(Icons.lock_outline, size: 14, color: AppColors.searchRatingText),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
