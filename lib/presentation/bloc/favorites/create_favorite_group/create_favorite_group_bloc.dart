import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_group_model.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'create_favorite_group_event.dart';
part 'create_favorite_group_state.dart';

class CreateFavoriteGroupBloc
    extends Bloc<ICreateFavoriteGroupEvent, ICreateFavoriteGroupState> {
  CreateFavoriteGroupBloc() : super(const CreateFavoriteGroupInitial()) {
    on<SubmitCreateFavoriteGroupEvent>(_submit);
  }

  FutureOr<void> _submit(
    SubmitCreateFavoriteGroupEvent event,
    Emitter<ICreateFavoriteGroupState> emit,
  ) async {
    emit(const CreateFavoriteGroupLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<FavoriteGroupModel>?, FavoritesEntity>
      >(instanceName: 'CreateFavoriteGroup');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(CreateFavoriteGroupFailed(failure.message)),
        (value) => emit(CreateFavoriteGroupSucceeded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(CreateFavoriteGroupFailed(error.toString()));
    }
  }
}
