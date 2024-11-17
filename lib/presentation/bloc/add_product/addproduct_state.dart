import 'package:equatable/equatable.dart';
import 'package:inventory_management_system/data/models/product_model.dart';

sealed class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

final class AddProductInitial extends AddProductState {}

final class AddProductLoadingState extends AddProductState {}

final class AddProductSuccessState extends AddProductState {
  final Products product;

  const AddProductSuccessState({required this.product});

  @override
  List<Object> get props => [product];
}

final class AddProductErrorState extends AddProductState {
  final String errorMessage;

  const AddProductErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// update the data
final class UpdateProductInitial extends AddProductState {}

final class UpdateProductLoadingState extends AddProductState {}

final class UpdateProductSuccessState extends AddProductState {
  final Products updatedProduct;

  const UpdateProductSuccessState({required this.updatedProduct});

  @override
  List<Object> get props => [updatedProduct];
}

final class UpdateProductErrorState extends AddProductState {
  final String errorMessage;

  const UpdateProductErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// delete the date

final class DeleteProductInitial extends AddProductState {}

final class DeleteProductLoadingState extends AddProductState {}

final class DeleteProductSuccessState extends AddProductState {}

final class DeleteProductErrorState extends AddProductState {
  final String errorMessage;

  const DeleteProductErrorState({required this.errorMessage});
}
