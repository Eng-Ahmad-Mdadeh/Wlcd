import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart' show Iconsax;
import 'package:share_plus/share_plus.dart' show ShareParams, SharePlus;
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/domain/entity/booking/get_available_slots_entity.dart';
import 'package:wlcd/domain/entity/instructor/get_instructor_entity.dart';
import 'package:wlcd/presentation/bloc/booking/available_slots/available_slots_bloc.dart';
import 'package:wlcd/presentation/bloc/instructor/instructor/instructor_bloc.dart';
import 'package:wlcd/presentation/screens/teachers/teacher_profile/widgets/teacher_profile_widgets.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final entity = GetInstructorEntity(instructorId: id);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => InstructorBloc()..add(LoadInstructorEvent(entity)),
        ),
        BlocProvider(
          create: (_) => AvailableSlotsBloc()
            ..add(
              LoadAvailableSlotsEvent(
                GetAvailableSlotsEntity(instructorId: id),
              ),
            ),
        ),
      ],
      child: _TeacherProfileBody(entity: entity),
    );
  }
}

class _TeacherProfileBody extends StatelessWidget {
  const _TeacherProfileBody({required this.entity});

  final GetInstructorEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstructorBloc, IInstructorState>(
      builder: (context, state) {
        if (state is InstructorFailed) {
          return Scaffold(
            backgroundColor: AppColors.teacherBackground,
            body: RetryWidget(onReload: () => context.read<InstructorBloc>().add(LoadInstructorEvent(entity))),
          );
        }

        if (state is! InstructorLoaded || state.instructor == null) {
          return const Scaffold(backgroundColor: AppColors.teacherBackground, body: LoadingWidget(0));
        }

        return _buildProfile(context, state.instructor!);
      },
    );
  }

  Widget _buildProfile(BuildContext context, InstructorModel teacher) {
    return Scaffold(
      backgroundColor: AppColors.teacherBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: AppHeight.h300,
            actionsPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            actions: [
              InkWell(
                onTap: () async {
                  final box = context.findRenderObject() as RenderBox?;
                  await SharePlus.instance.share(
                    ShareParams(
                      text: "شارك ملف المعلم الشخصي",
                      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: AppPaddingWidth.p15),
                  child: Icon(Iconsax.share_outline),
                ),
              ),
            ],
            surfaceTintColor: AppColors.white,
            flexibleSpace: FlexibleSpaceBar(background: TeacherProfileHero(teacher: teacher)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppPaddingWidth.p20,
              AppPaddingHeight.p20,
              AppPaddingWidth.p20,
              AppPaddingHeight.p40,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                TeacherProfileStats(teacher: teacher),
                SizedBox(height: AppHeight.h20),
                TeacherProfileActions(teacher: teacher),
                SizedBox(height: AppHeight.h24),
                TeacherAboutCard(teacher: teacher),
                SizedBox(height: AppHeight.h20),
                TeacherCoursesCard(teacher: teacher),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
