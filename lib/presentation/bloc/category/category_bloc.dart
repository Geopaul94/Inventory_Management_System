import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory_management_system/data/models/catergorey/category_model.dart';
import 'package:inventory_management_system/data/repository/category/category_repository.dart';


part 'category_event.dart';
part 'category_state.dart';




class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    // Register the event handlers in the constructor
    on<OnAddNewCategoryEvent>(_addnewcategory);
    on<OnFetchAllCategoryEvent>(_fetchallcategory);
  }

  // Handle adding new category
  Future<void> _addnewcategory(
      OnAddNewCategoryEvent event, Emitter<CategoryState> emit) async {
    final category = event.categoryModel;

    emit(AddCategoryLoadingstate()); // Emit loading state

    try {
      await FirestoreServiceCategoryModel().addCategorywithImage(category);


      emit(AddCategoryedSucessState()); // Emit success state
    } catch (e) {
      if (e is FirebaseException) {
        emit(AddCategoryErrorState(error: e.message.toString())); // Emit error state
      } else {
        emit(AddCategoryErrorState(error: e.toString()));
      }
    }
  }

  // Handle fetching all categories
  Future<void> _fetchallcategory(
      OnFetchAllCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(FetchAllCategoryLoadingState()); // Emit loading state for fetching

    try {
      final List<CategoryModel> categories =
          await FirestoreServiceCategoryModel().fetchCategories();
          categories.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        
      emit(FetchAllCategoryInitialState(categoryModel: categories)); // Emit success state with data
    } catch (e) {
      emit(FetchAllCategoryErrorState(error: e.toString())); // Emit error state
    }
  }
}
