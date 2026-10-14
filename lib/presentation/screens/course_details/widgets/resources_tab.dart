import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';
import 'package:wlcd/data/model/course_details/course_resources_tab/course_resources_tab_model.dart';

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({super.key, required this.resources});
  final CourseResourcesTabModel? resources;
  @override
  Widget build(BuildContext context) {
    final items = resources?.accessible == true
        ? [...resources!.data]
        : <dynamic>[];
    items.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return ListView.separated(
      key: const PageStorageKey('resources-tab-scroll'),
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p18,
        0,
        AppPaddingWidth.p18,
        AppPaddingHeight.p90,
      ),
      itemCount: items.isEmpty ? 2 : items.length + 1,
      separatorBuilder: (_, _) => SizedBox(height: AppHeight.h10),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SectionTitle(
            text: 'Resources',
            fontSize: 18,
            color: AppColors.searchCardTitle,
          );
        }
        if (items.isEmpty) {
          return BodyTitle(
            text: resources?.accessible == true
                ? 'No resources available.'
                : 'Content is not available. Sign in or enroll if required.',
            fontSize: 13,
            color: AppColors.searchRatingText,
          );
        }
        final resource = items[index - 1];
        return ListTile(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.searchCardBorder),
            borderRadius: BorderRadius.circular(AppRadius.r12),
          ),
          leading: const Icon(
            Icons.insert_drive_file_outlined,
            color: AppColors.primary,
          ),
          title: BodyTitle(
            text: resource.title,
            fontSize: 14,
            color: AppColors.searchCardTitle,
          ),
          subtitle: BodyTitle(
            text: resource.resourceType,
            fontSize: 12,
            color: AppColors.searchRatingText,
          ),
        );
      },
    );
  }
}
