part of 'get_course_details_bloc.dart';

sealed class IGetCourseDetailsState extends Equatable {
  const IGetCourseDetailsState();
}

final class GetCourseDetailsInitial extends IGetCourseDetailsState {
  const GetCourseDetailsInitial();
  @override
  List<Object?> get props => const [];
}

final class GetCourseDetailsLoading extends IGetCourseDetailsState {
  const GetCourseDetailsLoading();
  @override
  List<Object?> get props => const [];
}

final class GetCourseDetailsLoaded extends IGetCourseDetailsState {
  const GetCourseDetailsLoaded(this.getCourseDetails);

  final CourseDetailsModel? getCourseDetails;

  @override
  List<Object?> get props => [getCourseDetails];
}

final class GetCourseDetailsFailed extends IGetCourseDetailsState {
  const GetCourseDetailsFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
