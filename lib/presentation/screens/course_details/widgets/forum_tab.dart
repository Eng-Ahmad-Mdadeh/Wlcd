import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';
import 'package:wlcd/data/model/course_details/course_forum_tab/course_forum_tab_model.dart';

class ForumTab extends StatelessWidget {
  const ForumTab({super.key, required this.forum});
  final CourseForumTabModel? forum;

  @override
  Widget build(BuildContext context) {
    final data = forum;
    return ListView(
      key: const PageStorageKey('forum-tab-scroll'),
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p18,
        0,
        AppPaddingWidth.p18,
        AppPaddingHeight.p90,
      ),
      children: [
        const SectionTitle(
          text: 'Forum',
          fontSize: 18,
          color: AppColors.searchCardTitle,
        ),
        if (data == null || !data.accessible)
          const BodyTitle(
            text: 'Forum is not available. Sign in or enroll if required.',
            fontSize: 13,
          )
        else ...[
          if (data.data.isEmpty)
            const BodyTitle(text: 'No discussions yet.', fontSize: 13),
          for (final thread in data.data)
            ListTile(
              leading: Icon(
                thread.lockState == 'Locked'
                    ? Icons.lock_outline
                    : Icons.forum_outlined,
                color: AppColors.primary,
              ),
              title: BodyTitle(
                text: thread.title,
                fontSize: 14,
                color: AppColors.searchCardTitle,
              ),
              subtitle: Text(
                [
                  if (thread.lifecycleState != null) thread.lifecycleState!,
                  if (thread.createdAt != null)
                    thread.createdAt!.toLocal().toString().split(' ').first,
                ].join(' • '),
              ),
            ),
        ],
      ],
    );
  }
}
