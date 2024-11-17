

import 'package:equatable/equatable.dart';
import 'package:inventory_management_system/data/models/product_model.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_state.dart';

sealed class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductButtonClickedEvent extends AddProductEvent {
  final Products product;  // Ensure this is 'Products' if you're passing that model

  AddProductButtonClickedEvent({required this.product});

  @override
  List<Object> get props => [product];
}



class UpdateProductButtonClickedEvent extends AddProductEvent {

  final Products product;  // Ensure this is 'Products' if you're passing that model


  UpdateProductButtonClickedEvent({required this.product});


  @override

  List<Object> get props => [product];

}

class DeleteProductButtonClickedEvent extends AddProductEvent {
  final String productId; // Add a property to hold the product ID

  DeleteProductButtonClickedEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}