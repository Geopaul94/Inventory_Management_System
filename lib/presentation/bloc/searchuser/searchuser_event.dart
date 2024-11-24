
import 'package:equatable/equatable.dart';

sealed class CustomerSearchEvent extends Equatable {
  const CustomerSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchCustomerByNameEvent extends CustomerSearchEvent {
  final String query;

  SearchCustomerByNameEvent(this.query);

  @override
  List<Object> get props => [query];
}
