
part of 'add_post_bloc.dart';

@immutable
abstract class AddPostEvent {}

class PickImageFromGallery extends AddPostEvent {
  PickImageFromGallery(File croppedFile);
  // Constructor is not necessary for this event now
}

class OnPostButtonClickedEvent extends AddPostEvent {
  final String description;
  final String imagePath;
  final String productname;
  final String quantity;
  final String price;

  OnPostButtonClickedEvent({required this.description, required this.imagePath, required this.productname, required this.quantity, required this.price});
  




}

class RemoveImage extends AddPostEvent {}

class ClearImage extends AddPostEvent {}
