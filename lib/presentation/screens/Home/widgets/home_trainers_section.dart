import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/domain/entity/instructor/get_instructors_entity.dart';
import 'package:wlcd/presentation/bloc/instructor/instructors/instructors_bloc.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class HomeTrainersSection extends StatelessWidget {
  const HomeTrainersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstructorsBloc, IInstructorsState>(
      builder: (context, state) {
        if (state is InstructorsFailed) {
          return SizedBox(
            height: AppHeight.h225,
            child: RetryWidget(
              onReload: () => context.read<InstructorsBloc>().add(
                const LoadInstructorsEvent(GetInstructorsEntity()),
              ),
            ),
          );
        }

        if (state is! InstructorsLoaded) {
          return SizedBox(
            height: AppHeight.h225,
            child: const LoadingWidget(0),
          );
        }

        final trainers = state.instructors?.data ?? const <InstructorModel>[];
        if (trainers.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: AppHeight.h225,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: trainers.length,
            separatorBuilder: (_, __) => SizedBox(width: AppWidth.w14),
            itemBuilder: (context, index) => HomeTrainerCard(
              trainer: _toTeacherData(trainers[index], index),
            ),
          ),
        );
      },
    );
  }
}

TeacherData _toTeacherData(InstructorModel instructor, int index) {
  const accentColors = [
    AppColors.teacherPurple,
    AppColors.teacherCyan,
    AppColors.teacherAmber,
    AppColors.teacherGreen,
  ];
  final mediaId = instructor.mediaId;

  return TeacherData(
    name: instructor.displayName ?? '',
    specialty: instructor.specialty?.title ?? '',
    bio: instructor.biography ?? '',
    rating: instructor.rating ?? 0,
    students: (instructor.studentsCount ?? 0).toString(),
    imageUrl: mediaId == null || mediaId.isEmpty
        ? ''
        : '${ApiEndpoints.baseUrl.replaceFirst('/api/v1', '')}/media/public/$mediaId',
    accentColor: accentColors[index % accentColors.length],
  );
}

class HomeTrainerCard extends StatelessWidget {
  const HomeTrainerCard({super.key, required this.trainer});

  final TeacherData trainer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => TeacherProfileRoute($extra: trainer).push(context),
      child: Container(
        width: AppWidth.w150,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r18),
          border: Border.all(color: AppColors.teacherCardBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackCow.withValues(alpha: .08),
              blurRadius: AppRadius.r18,
              offset: Offset(0, AppHeight.h8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              imagePath: trainer.imageUrl,
              fit: BoxFit.fill,
              width: double.infinity,
              height: AppHeight.h135,
              radius: BorderRadius.only(
                topRight: Radius.circular(AppRadius.r18),
                topLeft: Radius.circular(AppRadius.r18),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    text: trainer.name,
                    color: AppColors.text,
                    fontSize: AppSize.s14,
                    fontWeight: FontWeight.w800,
                    maxLines: 1,
                  ),
                  SizedBox(height: AppHeight.h6),
                  BodyTitle(
                    text: trainer.specialty,
                    color: trainer.accentColor,
                    fontSize: AppSize.s11,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                  ),
                  SizedBox(height: AppHeight.h8),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, size: AppSize.s15, color: AppColors.searchStar),
                      SizedBox(width: AppWidth.w3),
                      BodyTitle(
                        text: trainer.rating.toStringAsFixed(1),
                        color: AppColors.seeMore,
                        fontSize: AppSize.s11,
                        fontWeight: FontWeight.w700,
                      ),
                      const Spacer(),
                      Icon(Icons.groups_rounded, size: AppSize.s14, color: AppColors.accent),
                      SizedBox(width: AppWidth.w3),
                      BodyTitle(
                        text: trainer.students,
                        color: AppColors.muted,
                        fontSize: AppSize.s10,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
