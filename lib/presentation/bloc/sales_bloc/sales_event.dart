part of 'sales_bloc.dart';

sealed class SalesEvent extends Equatable {
  const SalesEvent();

  @override
  List<Object> get props => [];
}






 ////////////////////////////// Add new sale Event /////////////////////////////
class OnAddNewSaleButtonClickedEvent extends SalesEvent {



final SalesDetailsModel salesDetailsModel;

  const OnAddNewSaleButtonClickedEvent({required this.salesDetailsModel});


  @override
  List<Object> get props => [salesDetailsModel];
}


 ////////////////////////////// Update sale Event  /////////////////////////////

class OnUpdateButtonClickedSaleEvent extends SalesEvent {
  final SalesDetailsModel salesDetailsModel;

  const OnUpdateButtonClickedSaleEvent({required this.salesDetailsModel});
  @override
  List<Object> get props => [salesDetailsModel];
}


 ////////////////////////////// Delete sale Event /////////////////////////////
class OnDeleteButtonClickedSaleEvent extends SalesEvent {
  final String saleId;

  const OnDeleteButtonClickedSaleEvent({required this.saleId});

  @override
  List<Object> get props => [saleId];
}


 ////////////////////////////// Delete sale Event /////////////////////////////

class FetchAllSalesInitialEvent extends SalesEvent {
  @override
  List<Object> get props => [];
}
