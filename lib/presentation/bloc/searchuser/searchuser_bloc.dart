import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory_management_system/presentation/bloc/searchuser/searchuser_event.dart';
import 'package:inventory_management_system/presentation/bloc/searchuser/searchuser_state.dart';


class CustomerSearchBloc extends Bloc<CustomerSearchEvent, CustomerSearchState> {
  final FirebaseFirestore firestore;

  CustomerSearchBloc(this.firestore) : super(CustomerSearchInitial()) {
    on<SearchCustomerByNameEvent>((event, emit) async {
      if (event.query.isEmpty) {
        emit(CustomerSearchInitial()); // Reset state if query is empty
        return;
      }

      emit(CustomerSearchLoadingState());
      try {
        final querySnapshot = await firestore
            .collection('customers')
            .where('customerName', isGreaterThanOrEqualTo: event.query)
            .where('customerName', isLessThanOrEqualTo: event.query + '\uf8ff')
            .get();

        emit(CustomerSearchSuccessState(querySnapshot.docs));
      } catch (e) {
        emit(CustomerSearchErrorState(e.toString()));
      }
    });
  }
}
