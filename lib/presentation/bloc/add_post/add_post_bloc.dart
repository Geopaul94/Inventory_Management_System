import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';  // Import image_cropper package
import 'package:inventory_management_system/presentation/bloc/add_post/add_post_state.dart';

part 'add_post_event.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();

  AddPostBloc() : super(AddPostInitial()) {
    // Event to pick image from gallery
    on<PickImageFromGallery>((event, emit) async {
      emit(ImagePickedLoadingState());
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          // Convert XFile to File
          final imageFile = File(pickedFile.path);

          // Crop the picked image
          final croppedFile = await _imageCropper.cropImage(
            sourcePath: imageFile.path,
            // Aspect ratio and UI settings are now directly set using the methods
          );

          if (croppedFile != null) {
            emit(ImagePickedSuccessState(imageFile: croppedFile)); // Pass cropped file to UI
          } else {
            emit(ImagePickedErrorState(error: 'Image cropping failed'));
          }
        } else {
          emit(ImagePickedErrorState(error: 'No image selected'));
        }
      } catch (e) {
        emit(ImagePickedErrorState(error: e.toString()));
      }
    });

    // Event to remove the selected image
    on<RemoveImage>((event, emit) {
      emit(AddPostInitial());
    });

    // Event to clear the selected image (similar to remove)
    on<ClearImage>((event, emit) {
      emit(AddPostInitial());
    });
  }
}
