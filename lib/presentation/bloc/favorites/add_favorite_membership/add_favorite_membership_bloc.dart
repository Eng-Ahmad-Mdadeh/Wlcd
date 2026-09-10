import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_membership_model.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'add_favorite_membership_event.dart';
part 'add_favorite_membership_state.dart';

class AddFavoriteMembershipBloc
    extends Bloc<IAddFavoriteMembershipEvent, IAddFavoriteMembershipState> {
  AddFavoriteMembershipBloc() : super(const AddFavoriteMembershipInitial()) {
    on<SubmitAddFavoriteMembershipEvent>(_submit);
  }

  FutureOr<void> _submit(
    SubmitAddFavoriteMembershipEvent event,
    Emitter<IAddFavoriteMembershipState> emit,
  ) async {
    emit(const AddFavoriteMembershipLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<FavoriteMembershipModel>?, FavoritesEntity>
      >(instanceName: 'AddFavoriteMembership');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(AddFavoriteMembershipFailed(failure.message)),
        (value) => emit(AddFavoriteMembershipSucceeded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(AddFavoriteMembershipFailed(error.toString()));
    }
  }
}
