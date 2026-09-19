import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/presentation/bloc/course_details/get_curriculum/get_curriculum_bloc.dart';
import 'package:wlcd/presentation/bloc/course_details/get_lesson/get_lesson_bloc.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class LessonsTab extends StatelessWidget {
  const LessonsTab({super.key, required this.entity});

  final CourseDetailsEntity entity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetCurriculumBloc()..add(LoadGetCurriculumEvent(entity))),
        BlocProvider(create: (_) => GetLessonBloc()),
      ],
      child: _LessonsView(entity: entity),
    );
  }
}

class _LessonsView extends StatelessWidget {
  const _LessonsView({required this.entity});
  final CourseDetailsEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetLessonBloc, IGetLessonState>(
      listener: (context, state) {
        if (state case GetLessonLoaded(getLesson: final lesson?)) {
          _showLesson(context, lesson);
        } else if (state is GetLessonFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<GetCurriculumBloc, IGetCurriculumState>(
        builder: (context, state) {
          if (state is GetCurriculumFailed) {
            return RetryWidget(
              onReload: () => context.read<GetCurriculumBloc>().add(LoadGetCurriculumEvent(entity)),
            );
          }
          if (state is! GetCurriculumLoaded) return const LoadingWidget(0);
          final lessons = _curriculumLessons(state.getCurriculum);
          if (lessons.isEmpty) {
            return const Center(
              child: BodyTitle(text: 'No lessons available.', fontSize: 13, color: AppColors.searchRatingText),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => context.read<GetCurriculumBloc>().add(LoadGetCurriculumEvent(entity)),
            child: ListView.separated(
              key: const PageStorageKey('lessons-tab-scroll'),
              padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
              itemCount: lessons.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.searchCardBorder),
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                final lessonId = lesson['lessonId'] ?? lesson['id'];
                final title = lesson['title'] ?? lesson['name'] ?? 'Lesson ${index + 1}';
                final duration = lesson['contentDurationSeconds'] ?? lesson['durationSeconds'] ?? lesson['duration'];
                return ListTile(
                  leading: const Icon(Icons.play_circle_fill, size: 20, color: AppColors.primary),
                  title: BodyTitle(text: title.toString(), fontSize: 14, color: AppColors.searchCardTitle),
                  subtitle: duration == null
                      ? null
                      : BodyTitle(text: _duration(duration), fontSize: 12, color: AppColors.searchRatingText),
                  trailing: BlocBuilder<GetLessonBloc, IGetLessonState>(
                    builder: (_, lessonState) => lessonState is GetLessonLoading
                        ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.chevron_right),
                  ),
                  enabled: lessonId != null,
                  onTap: lessonId == null
                      ? null
                      : () => context.read<GetLessonBloc>().add(
                        LoadGetLessonEvent(entity.copyWith(lessonId: lessonId.toString())),
                      ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showLesson(BuildContext context, LessonModel lesson) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BodyTitle(text: lesson.title, fontSize: 18, color: AppColors.searchCardTitle),
            if (lesson.description?.isNotEmpty ?? false) ...[
              SizedBox(height: AppHeight.h10),
              BodyTitle(
                text: lesson.description!,
                fontSize: 13,
                color: AppColors.searchRatingText,
                overflow: TextOverflow.visible,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> _curriculumLessons(CurriculumModel? curriculum) {
  if (curriculum == null) return const [];
  final result = <Map<String, dynamic>>[];
  for (final section in curriculum.sections.whereType<Map>()) {
    final map = Map<String, dynamic>.from(section);
    final lessons = map['lessons'] ?? map['items'];
    if (lessons is List) {
      result.addAll(lessons.whereType<Map>().map((item) => Map<String, dynamic>.from(item)));
    }
  }
  return result;
}

String _duration(dynamic value) {
  if (value is! num) return value.toString();
  final duration = Duration(seconds: value.round());
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
