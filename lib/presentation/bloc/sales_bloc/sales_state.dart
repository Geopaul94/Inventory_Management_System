part of 'sales_bloc.dart';

sealed class SalesState extends Equatable {
  const SalesState();

  @override
  List<Object> get props => [];
}

final class SalesInitial extends SalesState {
  @override
  List<Object> get props => [];
}


 ////////////////////////////// Add new sale/////////////////////////////
 


class AddNewSaleLoadingState extends SalesState {
  @override
  List<Object> get props => [];
}

class AddNewSaleErrorState extends SalesState {
  final String error;

  AddNewSaleErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class AddNewSaleSuccessState extends SalesState {
  @override
  List<Object> get props => [];
}
 

 ////////////////////////////// update sale/////////////////////////////
 


 class UpdateSaleLoadingState extends SalesState {
  @override
  List<Object> get props => [];
}

class UpdateSaleErrorState extends SalesState {
  final String error;

  UpdateSaleErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class UpdateSaleSuccessState extends SalesState {
  @override
  List<Object> get props => [];
}
 




 ////////////////////////////// Delete sale/////////////////////////////
 


 class DeleteSaleLoadingState extends SalesState {
  @override
  List<Object> get props => [];
}

class DeleteSaleErrorState extends SalesState {
  final String error;

  DeleteSaleErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class DeleteSaleSuccessState extends SalesState {
  @override
  List<Object> get props => [];
}
 




 ////////////////////////////// fetch all  sale/////////////////////////////
 

class FetchAllSaleLoadingState extends SalesState {
  @override
  List<Object> get props => [];
}

class FetchAllSaleErrorState extends SalesState {
  final String error;

  FetchAllSaleErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class FetchAllSaleSuccessState extends SalesState {
  final List<SalesDetailsModel> salesDetailsModel;

  FetchAllSaleSuccessState({required this.salesDetailsModel});
  @override
  List<Object> get props => [salesDetailsModel];
}