import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/catalog/get_featured_courses_entity.dart';

class FeaturedCoursesQueryCubit extends Cubit<GetFeaturedCoursesEntity> {
  FeaturedCoursesQueryCubit() : super(const GetFeaturedCoursesEntity());

  void setCursor(String? cursor) => emit(
    state.copyWith(cursor: cursor, clearCursor: cursor == null),
  );

  void setLimit(int limit) => emit(state.copyWith(limit: limit));

  void reset() => emit(const GetFeaturedCoursesEntity());
}
