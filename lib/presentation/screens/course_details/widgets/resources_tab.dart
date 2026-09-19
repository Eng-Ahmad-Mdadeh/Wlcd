import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/presentation/bloc/course_details/list_resources/list_resources_bloc.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({super.key, required this.entity});

  final CourseDetailsEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListResourcesBloc()..add(LoadListResourcesEvent(entity)),
      child: _ResourcesView(entity: entity),
    );
  }
}

class _ResourcesView extends StatelessWidget {
  const _ResourcesView({required this.entity});
  final CourseDetailsEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListResourcesBloc, IListResourcesState>(
      builder: (context, state) {
        if (state is ListResourcesFailed) {
          return RetryWidget(
            onReload: () => context.read<ListResourcesBloc>().add(LoadListResourcesEvent(entity)),
          );
        }
        if (state is! ListResourcesLoaded) return const LoadingWidget(0);
        final json = state.listResources?.value ?? const <String, dynamic>{};
        final rawItems = json['items'] ?? json['resources'] ?? json['data'];
        final resources = rawItems is List
            ? rawItems.whereType<Map>().map((item) => Map<String, dynamic>.from(item)).toList()
            : const <Map<String, dynamic>>[];
        return RefreshIndicator(
          onRefresh: () async => context.read<ListResourcesBloc>().add(LoadListResourcesEvent(entity)),
          child: ListView.separated(
            key: const PageStorageKey('resources-tab-scroll'),
            padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
            itemCount: resources.isEmpty ? 1 : resources.length + 1,
            separatorBuilder: (_, __) => SizedBox(height: AppHeight.h10),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SectionTitle(text: 'Resources', fontSize: 18, color: AppColors.searchCardTitle);
              }
              final resource = resources[index - 1];
              final title = resource['fileName'] ?? resource['title'] ?? resource['name'] ?? 'Resource $index';
              final type = resource['mimeType'] ?? resource['type'];
              return ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.searchCardBorder),
                  borderRadius: BorderRadius.circular(AppRadius.r12),
                ),
                leading: const Icon(Icons.insert_drive_file_outlined, color: AppColors.primary),
                title: BodyTitle(text: title.toString(), fontSize: 14, color: AppColors.searchCardTitle),
                subtitle: type == null
                    ? null
                    : BodyTitle(text: type.toString(), fontSize: 12, color: AppColors.searchRatingText),
              );
            },
          ),
        );
      },
    );
  }
}
