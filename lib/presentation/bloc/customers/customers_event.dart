part of 'customers_bloc.dart';

sealed class CustomersEvent extends Equatable {
  const CustomersEvent();

  @override
  List<Object> get props => [];
}


class FetchAllCustomersEvent extends CustomersEvent {
  const FetchAllCustomersEvent();

  @override
  List<Object> get props => [];
}


class OnSaveButtonCustomerClikEvent extends CustomersEvent {
  final CustomerDetailsModel customerDetailsModel; // Corrected type

  const OnSaveButtonCustomerClikEvent({required this.customerDetailsModel});
  
  @override
  List<Object> get props => [customerDetailsModel];
}

class OnUpdateCustomerButtonClikEvent extends CustomersEvent {
  final CustomerDetailsModel customerDetailsModel; // Corrected type

  const OnUpdateCustomerButtonClikEvent({required this.customerDetailsModel});
  
  @override
  List<Object> get props => [customerDetailsModel];
}

class OnDeleteCustomerButtonClikEvent extends CustomersEvent {
  final String customerId; // Assuming customerId is a String

  const OnDeleteCustomerButtonClikEvent({required this.customerId});
  
  @override
  List<Object> get props => [customerId];
}