import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/data/repository/customer_details/cusomer_data.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  CustomersBloc() : super(CustomersInitial()) {
    on<FetchAllCustomersEvent>(_FetchAllCustomers);
    on<OnSaveButtonCustomerClikEvent>(_onSaveButtonCustomerClick);
    on<OnUpdateCustomerButtonClikEvent>(_onUpdateCustomerButtonClick);
    on<OnDeleteCustomerButtonClikEvent>(_onDeleteCustomerButtonClick);

    on<OnFetchSaledDetailsCusomerEvent>(_fetchcustomersales);
  }

  Future<void> _FetchAllCustomers(
      FetchAllCustomersEvent event, Emitter<CustomersState> emit) async {
    emit(FetchCustomersLoadingState()); // Emit loading state
    try {
      // Fetch all customers from Firestore service
      List<CustomerDetailsModel> customersList =
          await FirestoreServiceCustomer().fetchAllCustomers();

      customersList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      // Emit success state with the list of customers
      emit(FetchCustomersInitialState(customerDetails: customersList));
    } catch (error) {
      emit(FetchCustomersErrorState(
          Error: error.toString())); // Emit error state
    }
  }

  Future<void> _onSaveButtonCustomerClick(
      OnSaveButtonCustomerClikEvent event, Emitter<CustomersState> emit) async {
    final newCustomer = event.customerDetailsModel;
    emit(CustomersLoadingState());
    try {
      // Save customer details
      await FirestoreServiceCustomer().saveCustomer(customer: newCustomer);

      // Emit success state with the saved customer details
      emit(CustomersAddSuccessState(customerDetailsModel: newCustomer));
    } catch (error) {
      // If error occurs, emit the error state
      emit(CustomersErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> _onUpdateCustomerButtonClick(
      OnUpdateCustomerButtonClikEvent event,
      Emitter<CustomersState> emit) async {
    emit(CustomersLoadingState());
    try {
      // Logic to update customer details
      await FirestoreServiceCustomer()
          .updateCustomer(event.customerDetailsModel);

      // Emit success state with the updated customer details
      emit(CustomersUpdateSuccessState(
          customerDetailsModel: event.customerDetailsModel));
    } catch (error) {
      emit(CustomersErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> _onDeleteCustomerButtonClick(
      OnDeleteCustomerButtonClikEvent event,
      Emitter<CustomersState> emit) async {
    emit(CustomersLoadingState());
    try {
      // Logic to delete a customer
      await FirestoreServiceCustomer().deleteCustomer(event.customerId);

      // Emit success state with the deleted customer ID
      emit(CustomersDeleteSuccessState(customerId: event.customerId));
    } catch (error) {
      emit(CustomersErrorState(errorMessage: error.toString()));
    }
  }

// /// fetchcustomer sales report details

  Future<void> _fetchcustomersales(OnFetchSaledDetailsCusomerEvent event,
      Emitter<CustomersState> emit) async {
    emit(FetchCustomersLoadingState());

    try {
      List<SalesDetailsModel> salesDetails = await FirestoreServiceCustomer()
          .fetchCustomerSalesDetails(event.customerName);

      emit(FetchAllSaledDetailsCustomerInitialState(customersalesreport: salesDetails));
          } catch (e) {
      emit(FetchCustomersErrorState(Error: e.toString()));
    }
  }
}
