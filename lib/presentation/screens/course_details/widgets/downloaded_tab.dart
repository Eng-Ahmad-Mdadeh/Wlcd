import 'package:flutter/material.dart';
import 'package:wlcd/data/model/course_details/course_resources_tab/course_resources_tab_model.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/resources_tab.dart';

class DownloadedTab extends StatelessWidget {
  const DownloadedTab({super.key, required this.downloads});
  final CourseResourcesTabModel? downloads;

  @override
  Widget build(BuildContext context) => ResourcesTab(
    resources: downloads,
    title: 'Downloads',
    storageKey: 'downloads-tab-scroll',
  );
}
