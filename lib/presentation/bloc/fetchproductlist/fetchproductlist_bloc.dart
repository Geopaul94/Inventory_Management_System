import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory_management_system/data/models/product_model.dart';
import 'package:inventory_management_system/data/repository/product_data/product_data.dart';

part 'fetchproductlist_event.dart';
part 'fetchproductlist_state.dart';

class FetchProductListBloc
    extends Bloc<FetchProductListEvent, FetchProductListState> {
  FetchProductListBloc() : super(FetchProductListInitial()) {
    // Bind the event to the handler function
    on<FetchProductListInitialEvent>(_onFetchProductList);
  }

  // Handler function for fetching products
  Future<void> _onFetchProductList(FetchProductListInitialEvent event,
      Emitter<FetchProductListState> emit) async {
    emit(FetchProductListLoadingState()); // Emit loading state

    try {
      // Fetch the products
      List<Products> products = await fetchAllProducts();

      products.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Emit success state with the fetched products
      emit(FetchProductListSuccessState(products: products));
    } catch (error) {
      // Emit error state with error message
      emit(FetchProductListErrorState(errorMessage: error.toString()));
    }
  }
}
