import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';
import 'package:wlcd/data/model/course_details/course_resources_tab/course_resources_tab_model.dart';

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({
    super.key,
    required this.resources,
    this.title = 'Resources',
    this.storageKey = 'resources-tab-scroll',
  });
  final CourseResourcesTabModel? resources;
  final String title;
  final String storageKey;

  @override
  Widget build(BuildContext context) {
    final data = resources;
    final items = [...?data?.data]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return ListView(
      key: PageStorageKey(storageKey),
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p18,
        0,
        AppPaddingWidth.p18,
        AppPaddingHeight.p90,
      ),
      children: [
        SectionTitle(
          text: title,
          fontSize: 18,
          color: AppColors.searchCardTitle,
        ),
        if (data == null || !data.accessible)
          const BodyTitle(
            text: 'Content is not available. Sign in or enroll if required.',
            fontSize: 13,
          )
        else ...[
          Text('${data.resourceCount} resources'),
          if (items.isEmpty)
            const BodyTitle(text: 'No resources available.', fontSize: 13),
          for (final resource in items)
            ListTile(
              leading: const Icon(
                Icons.insert_drive_file_outlined,
                color: AppColors.primary,
              ),
              title: BodyTitle(
                text: resource.title,
                fontSize: 14,
                color: AppColors.searchCardTitle,
              ),
              subtitle: Text(
                '${resource.resourceType}${resource.fileSizeBytes == null ? '' : ' • ${resource.fileSizeBytes} bytes'}',
              ),
            ),
        ],
      ],
    );
  }
}
