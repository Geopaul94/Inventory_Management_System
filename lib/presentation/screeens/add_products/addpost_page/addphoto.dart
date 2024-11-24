import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

// class AddPhotoContainer extends StatefulWidget {
//   final Function(File?) onImageSelected; // Callback function

//   const AddPhotoContainer({super.key, required this.onImageSelected});

//   @override
//   _AddPhotoContainerState createState() => _AddPhotoContainerState();
// }

// class _AddPhotoContainerState extends State<AddPhotoContainer> {
//   File? _imageFile;

//   Future<void> _pickAndCropImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       final croppedFile = await _cropImage(pickedFile.path);

//       if (croppedFile != null) {
//         setState(() {
//           _imageFile = croppedFile;
//         });
//         widget.onImageSelected(_imageFile);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Image cropping was cancelled')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No image selected')),
//       );
//     }
//   }

//   Future<File?> _cropImage(String imagePath) async {
//     final croppedImage = await ImageCropper().cropImage(
//       sourcePath: imagePath,
//       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: 'Crop Image',
//           toolbarColor: Colors.blue,
//           toolbarWidgetColor: Colors.white,
//           lockAspectRatio: false,
//         ),
//         IOSUiSettings(title: 'Crop Image'),
//       ],
//     );
//     return croppedImage != null ? File(croppedImage.path) : null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return GestureDetector(
//       onTap: _pickAndCropImage,
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(),
//             borderRadius: const BorderRadius.all(Radius.circular(20))),
//         height: size.height * 0.42,
//         width: size.width * 0.85,
//         child: Stack(
//           children: [
//             if (_imageFile != null)
//               Center(
//                 child: Image.file(
//                   _imageFile!,
//                   fit: BoxFit.cover,
//                   width: size.width * 0.9,
//                   height: size.height * 0.35,
//                 ),
//               )
//             else
//               const Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(CupertinoIcons.photo, color: Colors.grey, size: 50),
//                     SizedBox(height: 5),
//                     Text('Add Image....',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600, color: Colors.grey)),
//                   ],
//                 ),
//               ),
//             if (_imageFile != null)
//               Positioned(
//                 bottom: 10,
//                 right: 10,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _imageFile = null;
//                     });
//                     widget.onImageSelected(null);
//                   },
//                   child: const Icon(Icons.delete, color: Colors.red, size: 30),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AddPhotoContainer extends StatefulWidget {
  final Function(File?) onImageSelected; // Callback function
  final String? initialImageUrl; // Existing image URL from Firestore (if any)

  const AddPhotoContainer({
    super.key,
    required this.onImageSelected,
    this.initialImageUrl, // Accept the initial image URL
  });

  @override
  _AddPhotoContainerState createState() => _AddPhotoContainerState();
}

class _AddPhotoContainerState extends State<AddPhotoContainer> {
  File? _imageFile;

  Future<void> _pickAndCropImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final croppedFile = await _cropImage(pickedFile.path);

      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
        });
        widget.onImageSelected(_imageFile);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image cropping was cancelled')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  Future<File?> _cropImage(String imagePath) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );
    return croppedImage != null ? File(croppedImage.path) : null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: _pickAndCropImage, // Allow user to pick an image when tapping
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        height: size.height * 0.42,
        width: size.width * 0.85,
        child: Stack(
          children: [
            // If the user has picked a new image, show that
            if (_imageFile != null)
              Center(
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: size.width * 0.9,
                  height: size.height * 0.35,
                ),
              )
            // If no new image is picked but there's an existing image, show that
            else if (widget.initialImageUrl != null)
              Center(
                child: Image.network(
                  widget.initialImageUrl!,
                  fit: BoxFit.cover,
                  width: size.width * 0.9,
                  height: size.height * 0.35,
                ),
              )
            // Otherwise, show the placeholder
            else
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.photo, color: Colors.grey, size: 50),
                    SizedBox(height: 5),
                    Text('Add Image....',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.grey)),
                  ],
                ),
              ),
            // Delete button to remove the selected image
            if (_imageFile != null)
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _imageFile = null;
                    });
                    widget.onImageSelected(null);
                  },
                  child: const Icon(Icons.delete, color: Colors.red, size: 30),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
