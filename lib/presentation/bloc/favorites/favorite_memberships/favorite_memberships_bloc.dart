import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_memberships_model.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'favorite_memberships_event.dart';
part 'favorite_memberships_state.dart';

class FavoriteMembershipsBloc
    extends Bloc<IFavoriteMembershipsEvent, IFavoriteMembershipsState> {
  FavoriteMembershipsBloc() : super(const FavoriteMembershipsInitial()) {
    on<LoadFavoriteMembershipsEvent>(_load);
  }

  FutureOr<void> _load(
    LoadFavoriteMembershipsEvent event,
    Emitter<IFavoriteMembershipsState> emit,
  ) async {
    emit(const FavoriteMembershipsLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<FavoriteMembershipsModel>?, FavoritesEntity>
      >(instanceName: 'ListFavoriteMemberships');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(FavoriteMembershipsFailed(failure.message)),
        (value) => emit(FavoriteMembershipsLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(FavoriteMembershipsFailed(error.toString()));
    }
  }
}
