part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}


final class OnAddNewCategoryEvent extends CategoryEvent{

final CategoryModel categoryModel;

  OnAddNewCategoryEvent({required this.categoryModel});

  @override
  List<Object> get props => [categoryModel];
}



final class OnUpdateCategoryEvent extends CategoryEvent{

final CategoryModel categoryModel;
final String categoryId;

  OnUpdateCategoryEvent(this.categoryId, {required this.categoryModel});

  @override
  List<Object> get props => [categoryModel,categoryId];
}


final class OnDeleteCategoryEvent extends CategoryEvent{

final String categoryId;

  OnDeleteCategoryEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}





 class OnFetchAllCategoryEvent extends CategoryEvent{



  @override
  List<Object> get props => [];
}