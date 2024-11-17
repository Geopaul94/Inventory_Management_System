import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';  // Import for XFile and cropped image

abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class ImagePickedLoadingState extends AddPostState {}

class ImagePickedSuccessState extends AddPostState {
  final CroppedFile imageFile; 

  ImagePickedSuccessState({required this.imageFile});
}

class ImagePickedErrorState extends AddPostState {
  final String error;

  ImagePickedErrorState({required this.error});
}

class ImageUploadingState extends AddPostState {}

class ImageUploadedState extends AddPostState {}

class ImageUploadErrorState extends AddPostState {
  final String error;

  ImageUploadErrorState({required this.error});
}
