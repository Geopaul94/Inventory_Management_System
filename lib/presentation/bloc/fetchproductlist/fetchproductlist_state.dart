part of 'fetchproductlist_bloc.dart';

abstract class FetchProductListState extends Equatable {
  const FetchProductListState();
  
  @override
  List<Object> get props => [];
}

// Initial state
class FetchProductListInitial extends FetchProductListState {}

// Loading state when fetching the product list
class FetchProductListLoadingState extends FetchProductListState {}

// Success state with a list of products
class FetchProductListSuccessState extends FetchProductListState {
  final List<Products> products;

  FetchProductListSuccessState({required this.products});

  @override
  List<Object> get props => [products];
}

// Error state with an error message
class FetchProductListErrorState extends FetchProductListState {
  final String errorMessage;

  FetchProductListErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class NavigateToAddProductState extends FetchProductListState{}
