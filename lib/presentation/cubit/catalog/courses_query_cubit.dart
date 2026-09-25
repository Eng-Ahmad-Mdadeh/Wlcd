import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';

/// Holds the canonical courses query shared by search and filter controls.
class CoursesQueryCubit extends Cubit<GetCoursesEntity> {
  CoursesQueryCubit({GetCoursesEntity initial = const GetCoursesEntity()})
    : super(initial);

  void setSearch(String value) {
    final query = value.trim();
    emit(state.copyWith(q: query.isEmpty ? null : query, cursor: null));
  }

  void setFilters(GetCoursesEntity filters) {
    emit(
      filters.copyWith(
        q: state.q,
        cursor: null,
        limit: state.limit,
      ),
    );
  }

  void clearFilters() {
    emit(GetCoursesEntity(q: state.q, limit: state.limit));
  }
}
