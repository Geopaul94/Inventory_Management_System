

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

sealed class CustomerSearchState extends Equatable {
  const CustomerSearchState();

  @override
  List<Object> get props => [];
}

class CustomerSearchInitial extends CustomerSearchState {}

class CustomerSearchLoadingState extends CustomerSearchState {}

class CustomerSearchSuccessState extends CustomerSearchState {
  final List<DocumentSnapshot> customers;

  CustomerSearchSuccessState(this.customers);

  @override
  List<Object> get props => [customers];
}

class CustomerSearchErrorState extends CustomerSearchState {
  final String error;

  CustomerSearchErrorState(this.error);

  @override
  List<Object> get props => [error];
}
