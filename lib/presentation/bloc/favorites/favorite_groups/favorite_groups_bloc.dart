import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_groups_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'favorite_groups_event.dart';
part 'favorite_groups_state.dart';

class FavoriteGroupsBloc
    extends Bloc<IFavoriteGroupsEvent, IFavoriteGroupsState> {
  FavoriteGroupsBloc() : super(const FavoriteGroupsInitial()) {
    on<LoadFavoriteGroupsEvent>(_load);
  }

  FutureOr<void> _load(
    LoadFavoriteGroupsEvent event,
    Emitter<IFavoriteGroupsState> emit,
  ) async {
    emit(const FavoriteGroupsLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<FavoriteGroupsModel>?, Null>
      >(instanceName: 'ListFavoriteGroups');
      final response = await usecase(null);
      response.fold(
        (failure) => emit(FavoriteGroupsFailed(failure.message)),
        (value) => emit(FavoriteGroupsLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(FavoriteGroupsFailed(error.toString()));
    }
  }
}
