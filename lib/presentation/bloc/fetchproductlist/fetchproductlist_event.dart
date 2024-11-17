part of 'fetchproductlist_bloc.dart';

abstract class FetchProductListEvent extends Equatable {
  const FetchProductListEvent();

  @override
  List<Object> get props => [];
}

// Event to trigger fetching of product list
class FetchProductListInitialEvent extends FetchProductListEvent {}

class NavigateToAddProduct extends FetchProductListEvent{}
