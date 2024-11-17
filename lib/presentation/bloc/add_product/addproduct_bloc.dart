import 'package:bloc/bloc.dart';
import 'package:inventory_management_system/data/repository/product_data/product_data.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_event.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_state.dart';
class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {

  AddProductBloc() : super(AddProductInitial()) {

    on<AddProductButtonClickedEvent>(_onAddProductButtonClicked);

    on<UpdateProductButtonClickedEvent>(_onUpdateButtonClicked);

  }



  Future<void> _onAddProductButtonClicked(
      AddProductButtonClickedEvent event, Emitter<AddProductState> emit) async {
    final product = event.product;

    // Emit loading state to show a loading indicator
    emit(AddProductLoadingState());

    try {
      // Call uploadProductWithImage asynchronously
      await uploadProductWithImage(product);

      // If successful, emit success state with the added product
      emit(AddProductSuccessState(product: product)); // Pass the product to the success state
    } catch (error) {
      // In case of an error, emit error state with the error message
      emit(AddProductErrorState(errorMessage: error.toString())); // Pass the error message to the error state
    }
  }


Future<void> _onUpdateButtonClicked(UpdateProductButtonClickedEvent event, Emitter<AddProductState> emit) async {
  final product = event.product;

  emit(UpdateProductLoadingState());

  try {
    // Call updateProductInFirestore asynchronously
    await updateProductInFirestore(product);

    // If successful, emit success state with the updated product
    emit(UpdateProductSuccessState(updatedProduct: product)); // Pass the product to the success state
  } catch (error) {
    // In case of an error, emit error state with the error message
    emit(UpdateProductErrorState(errorMessage: error.toString())); // Pass the error message to the error state
  }
}






Future<void> _onDeleteProductButtonClicked(
    DeleteProductButtonClickedEvent event, Emitter<AddProductState> emit) async {
  final productId = event.productId; // Get the product ID from the event

  // Emit loading state to show a loading indicator
  emit(DeleteProductLoadingState());

  try {
    // Call deleteProductFromFirestore asynchronously
    await deleteProductFromFirestore(productId);

    // If successful, emit success state
    emit(DeleteProductSuccessState()); // No need to pass the product ID here
  } catch (error) {
    // In case of an error, emit error state with the error message
    emit(DeleteProductErrorState(errorMessage: error.toString())); // Pass the error message to the error state
  }
}}