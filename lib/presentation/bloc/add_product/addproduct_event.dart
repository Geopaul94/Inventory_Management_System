

import 'package:equatable/equatable.dart';
import 'package:inventory_management_system/data/models/product_model.dart';

sealed class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductButtonClickedEvent extends AddProductEvent {
  final Products product;  // Ensure this is 'Products' if you're passing that model

  const AddProductButtonClickedEvent({required this.product});

  @override
  List<Object> get props => [product];
}



class UpdateProductButtonClickedEvent extends AddProductEvent {

  final Products product;  // Ensure this is 'Products' if you're passing that model

final  String id;
  const UpdateProductButtonClickedEvent(this.id, {required this.product});


  @override

  List<Object> get props => [product , id];

}

class DeleteProductButtonClickedEvent extends AddProductEvent {
  final String productId; // Add a property to hold the product ID

  const DeleteProductButtonClickedEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}