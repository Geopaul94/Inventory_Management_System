


import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management_system/presentation/bloc/add_post/add_post_state.dart';


part 'add_post_event.dart';


class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final ImagePicker _picker = ImagePicker();

  AddPostBloc() : super(AddPostInitial()) {
    on<PickImageFromGallery>((event, emit) async {
      emit(ImagePickedLoadingState());
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          emit(ImagePickedSuccessState(imageFile: pickedFile));
        } else {
          emit(ImagePickedErrorState(error: 'No image selected'));
        }
      } catch (e) {
        emit(ImagePickedErrorState(error: e.toString()));
      }
    });


    on<RemoveImage>((event, emit) {
      emit(AddPostInitial());
    });

    on<ClearImage>((event, emit) {
      emit(AddPostInitial());
    });

}
}