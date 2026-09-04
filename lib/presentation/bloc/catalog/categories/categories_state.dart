part of 'categories_bloc.dart';

sealed class ICategoriesState extends Equatable {
  const ICategoriesState();
}

final class CategoriesInitial extends ICategoriesState {
  const CategoriesInitial();

  @override
  List<Object?> get props => const [];
}

final class CategoriesLoading extends ICategoriesState {
  const CategoriesLoading();

  @override
  List<Object?> get props => const [];
}

final class CategoriesLoaded extends ICategoriesState {
  const CategoriesLoaded(this.categories);

  final CategoriesModel? categories;

  @override
  List<Object?> get props => [categories];
}

final class CategoriesFailed extends ICategoriesState {
  const CategoriesFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
