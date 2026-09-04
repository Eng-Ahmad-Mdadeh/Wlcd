import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/categories/categories_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<ICategoriesEvent, ICategoriesState> {
  CategoriesBloc() : super(const CategoriesInitial()) {
    on<LoadCategoriesEvent>(_load);
  }

  FutureOr<void> _load(
    LoadCategoriesEvent event,
    Emitter<ICategoriesState> emit,
  ) async {
    emit(const CategoriesLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<CategoriesModel>?, Null>>(
        instanceName: 'ListCategories',
      );
      final response = await usecase(null);
      response.fold(
        (failure) => emit(CategoriesFailed(failure.message)),
        (value) => emit(CategoriesLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(CategoriesFailed(error.toString()));
    }
  }
}
