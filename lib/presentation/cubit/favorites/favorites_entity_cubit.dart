import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';

class FavoritesEntityCubit extends Cubit<FavoritesEntity> {
  FavoritesEntityCubit() : super(const FavoritesEntity());

  void setFavoriteGroupId(String? value) => emit(state.copyWith(favoriteGroupId: value, clearFavoriteGroupId: value == null));
  void setCourseId(String? value) => emit(state.copyWith(courseId: value, clearCourseId: value == null));
  void setName(String value) => emit(state.copyWith(name: value));
  void setIdempotencyKey(String value) => emit(state.copyWith(idempotencyKey: value));
  void reset() => emit(const FavoritesEntity());
}
