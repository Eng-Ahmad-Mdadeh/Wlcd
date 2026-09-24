import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/instructor/get_instructors_entity.dart';

class InstructorsQueryCubit extends Cubit<GetInstructorsEntity> {
  InstructorsQueryCubit() : super(const GetInstructorsEntity());

  void setSearch(String? q) => emit(
    state.copyWith(q: q, clearQ: q == null || q.isEmpty, clearCursor: true),
  );

  void setCategories({String? categoryId, List<String> categoryIds = const []}) =>
      emit(state.copyWith(
        categoryId: categoryId,
        categoryIds: categoryIds,
        clearCategoryId: categoryId == null,
        clearCursor: true,
      ));

  void setSort(String? sort) => emit(
    state.copyWith(sort: sort, clearSort: sort == null, clearCursor: true),
  );

  void setCursor(String? cursor) => emit(
    state.copyWith(cursor: cursor, clearCursor: cursor == null),
  );

  void setLimit(int limit) => emit(state.copyWith(limit: limit, clearCursor: true));

  void reset() => emit(const GetInstructorsEntity());
}
