import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/data/repository/customer_details/cusomer_data.dart';
import 'package:inventory_management_system/data/repository/sale/sales_data.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_state.dart';
import 'package:inventory_management_system/presentation/bloc/customers/customers_bloc.dart';

part 'sales_event.dart';
part 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  SalesBloc() : super(SalesInitial()) {
    on<SalesEvent>((event, emit) {
      on<FetchAllSalesInitialEvent>(_fetchallsalesinitial);
      on<OnAddNewSaleButtonClickedEvent>(_addnewsalebuttonclicked);
      on<OnUpdateButtonClickedSaleEvent>(_onUpdateCustomerButtonClick);
      on<OnDeleteButtonClickedSaleEvent>(_onDeleteCustomerButtonClick);
    });
  }

  Future<void> _onDeleteCustomerButtonClick(
      OnDeleteButtonClickedSaleEvent event, Emitter<SalesState> emit) async {
    emit(DeleteSaleLoadingState());

    try {
      // Delete the sale from Firestore by saleId
      await FirebaseFirestore.instance
          .collection('sales')
          .doc(event.saleId)
          .delete();

      // Emit success state after deletion
      emit(DeleteSaleSuccessState());
      print('Sale deleted successfully!');
    } catch (e) {
      // Emit error state if an error occurs during deletion
      emit(DeleteSaleErrorState(error: e.toString()));
      print('Error deleting sale: $e');
    }
  }

  Future<void> _fetchallsalesinitial(
      FetchAllSalesInitialEvent event, Emitter<SalesState> emit) async {
    emit(FetchAllSaleLoadingState());

    try {
      // Fetch all sales from Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('sales').get();

      // Convert Firestore documents to a list of SalesDetailsModel
      List<SalesDetailsModel> salesDetails = querySnapshot.docs.map((doc) {
        // Cast the QueryDocumentSnapshot to DocumentSnapshot<Map<String, dynamic>>
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            doc as DocumentSnapshot<Map<String, dynamic>>;
        return SalesDetailsModel.fromFirestore(snapshot);
      }).toList();

      // Emit success state with fetched sales details
      emit(FetchAllSaleSuccessState(salesDetailsModel: salesDetails));
      print('Sales fetched successfully!');
    } catch (e) {
      // Emit error state if an error occurs during fetching
      emit(FetchAllSaleErrorState(error: e.toString()));
      print('Error fetching sales: $e');
    }
  }

  Future<void> _addnewsalebuttonclicked(
      OnAddNewSaleButtonClickedEvent event, Emitter<SalesState> emit) async {
    emit(AddNewSaleLoadingState());
    try {
      await FirestoreServiceSales().addNewSale(event.salesDetailsModel);

      emit(AddNewSaleSuccessState());
    } catch (error) {
      emit(AddNewSaleErrorState(error: error.toString()));
      print('Error adding sale: $error');
    }
  }

  Future<void> _onUpdateCustomerButtonClick(
      OnUpdateButtonClickedSaleEvent event, Emitter<SalesState> emit) async {
    emit(UpdateSaleLoadingState());
    try {
      await FirestoreServiceSales().updateSale(event.salesDetailsModel);

      emit(UpdateSaleSuccessState());
    } catch (error) {
      emit(UpdateSaleErrorState(error: error.toString()));
      print('Error adding sale: $error');
    }
  }
}
