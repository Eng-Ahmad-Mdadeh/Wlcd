part of 'categories_bloc.dart';

sealed class ICategoriesEvent extends Equatable {
  const ICategoriesEvent();
}

final class LoadCategoriesEvent extends ICategoriesEvent {
  const LoadCategoriesEvent();

  @override
  List<Object?> get props => const [];
}
