part of 'customers_bloc.dart';

sealed class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object> get props => [];
}

// Initial state
class CustomersInitial extends CustomersState {}

class FetchCustomersInitialState extends CustomersState {
  final List<CustomerDetailsModel> customerDetails;

  const FetchCustomersInitialState({required this.customerDetails});

  @override
  List<Object> get props => [customerDetails];
}

class FetchCustomersSuccessState extends CustomersState {}

class FetchCustomersLoadingState extends CustomersState {}

class FetchCustomersErrorState extends CustomersState {
  final String Error;

  FetchCustomersErrorState({required this.Error});

  @override
  List<Object> get props => [Error];
}

// Loading state
class CustomersLoadingState extends CustomersState {}

// Success state for adding a new customer
class CustomersAddSuccessState extends CustomersState {
  final CustomerDetailsModel customerDetailsModel;

  const CustomersAddSuccessState({required this.customerDetailsModel});

  @override
  List<Object> get props => [customerDetailsModel];
}

// Success state for updating a customer
class CustomersUpdateSuccessState extends CustomersState {
  final CustomerDetailsModel customerDetailsModel;

  const CustomersUpdateSuccessState({required this.customerDetailsModel});

  @override
  List<Object> get props => [customerDetailsModel];
}

class CustomersLoadingUpdateState extends CustomersState {}

class CustomersErrorUpdateState extends CustomersState {
  final String error;

  CustomersErrorUpdateState({required this.error});

  @override
  List<Object> get props => [error];
}

// Success state for deleting a customer
class CustomersDeleteSuccessState extends CustomersState {
  final String customerId; // Assuming customerId is a String

  const CustomersDeleteSuccessState({required this.customerId});

  @override
  List<Object> get props => [customerId];
}

// Success state for deleting a customer
class CustomersDeleteErrorState extends CustomersState {
  final String error;

  CustomersDeleteErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class CustomersDeleteLoadingState extends CustomersState {
  @override
  List<Object> get props => [];
}

// Error state
class CustomersErrorState extends CustomersState {
  final String errorMessage;

  const CustomersErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
