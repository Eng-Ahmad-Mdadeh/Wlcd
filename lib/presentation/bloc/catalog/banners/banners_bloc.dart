import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/banners/banners_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'banners_event.dart';
part 'banners_state.dart';

class BannersBloc extends Bloc<IBannersEvent, IBannersState> {
  BannersBloc() : super(const BannersInitial()) {
    on<LoadBannersEvent>(_load);
  }

  FutureOr<void> _load(
    LoadBannersEvent event,
    Emitter<IBannersState> emit,
  ) async {
    emit(const BannersLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<BannersModel>?, Null>>(
        instanceName: 'GetBanners',
      );
      final response = await usecase(null);
      response.fold(
        (failure) => emit(BannersFailed(failure.message)),
        (value) => emit(BannersLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(BannersFailed(error.toString()));
    }
  }
}
