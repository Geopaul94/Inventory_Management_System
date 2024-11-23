part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class AddCategoryLoadingstate extends CategoryState {}

class AddCategoryedSucessState extends CategoryState {}

class AddCategoryErrorState extends CategoryState {
  final String error;

  AddCategoryErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class CategoryUpdateLoadingState extends CategoryState {}

class CategoryUpdateSuccessState extends CategoryState {}

class CategoryUpdateErrorState extends CategoryState {
  final String error;

  CategoryUpdateErrorState({required this.error});
}

class CategoryDeleteLoadingState extends CategoryState {}

class CategoryDeleteSuccessState extends CategoryState {}

class CategoryDeleteErrorState extends CategoryState {
  final String error;

  CategoryDeleteErrorState({required this.error});
}

class FetchAllCategoryInitialState extends CategoryState {
  final List<CategoryModel> categoryModel;

  FetchAllCategoryInitialState({required this.categoryModel});

  @override
  List<Object> get props => [categoryModel];
}

class FetchAllCategoryLoadingState extends CategoryState {}

class FetchAllCategorySuccessState extends CategoryState {}

class FetchAllCategoryErrorState extends CategoryState {
  final String error;

  FetchAllCategoryErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
