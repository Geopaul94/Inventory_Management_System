import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:inventory_management_system/presentation/bloc/add_post/add_post_bloc.dart';

class AddPhotoContainer extends StatelessWidget {
  final XFile? imageFile;
  final VoidCallback? onRemove;

  const AddPhotoContainer({this.imageFile, this.onRemove, super.key});

  // Method to crop the image
  Future<File?> _cropImage(BuildContext context, String imagePath) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    return croppedImage != null ? File(croppedImage.path) : null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        // Trigger image selection from the gallery
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          // Crop the image after picking it
          final croppedFile = await _cropImage(context, pickedFile.path);

          if (croppedFile != null) {
            // Pass the cropped file to the bloc for further processing
            BlocProvider.of<AddPostBloc>(context).add(
              PickImageFromGallery(croppedFile), // Update your event with croppedFile
            );
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        height: size.height * 0.35,
        width: size.width * 0.9,
        child: Stack(
          children: [
            // Display the selected image if available
            if (imageFile != null)
              Center(
                child: Image.file(
                  File(imageFile!.path),
                  fit: BoxFit.cover,
                  width: size.width * 0.9,
                  height: size.height * 0.35,
                ),
              )
            else
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.photo,
                      color: Colors.grey,
                      size: 50,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Add Image....',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            // Show delete icon only if the image is picked
            if (imageFile != null)
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onRemove,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
