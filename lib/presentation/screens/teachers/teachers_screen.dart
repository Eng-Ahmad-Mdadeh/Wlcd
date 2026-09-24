import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/instructor/get_instructors_entity.dart';
import 'package:wlcd/presentation/bloc/instructor/instructors/instructors_bloc.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teachers_list.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InstructorsBloc()
        ..add(const LoadInstructorsEvent(GetInstructorsEntity())),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'المدرسون',
          showBackButton: true,
        ),
        body: BlocBuilder<InstructorsBloc, IInstructorsState>(
          builder: (context, state) {
            if (state is InstructorsFailed) {
              return RetryWidget(
                onReload: () => context.read<InstructorsBloc>().add(
                  const LoadInstructorsEvent(GetInstructorsEntity()),
                ),
              );
            }
            if (state is InstructorsLoaded) {
              return TeachersList(
                teachers: state.instructors?.data ?? const [],
              );
            }
            return const LoadingWidget(0);
          },
        ),
      ),
    );
  }
}
