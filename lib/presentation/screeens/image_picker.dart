import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:inventory_management_system/utilities/functions/deveice_info.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerCropper extends StatefulWidget {
  @override
  _ImagePickerCropperState createState() => _ImagePickerCropperState();
}

class _ImagePickerCropperState extends State<ImagePickerCropper> {


   @override

  // void initState() {

  //   super.initState();

  //   requestStoragePermission();

  // }
  File? _imageFile;




  // Method to request permissions before picking the image
  Future<void> _requestPermissionAndPickImage() async {
    PermissionStatus permissionStatus = await Permission.photos.request();
    if (permissionStatus.isGranted) {
      _pickImage();
    } else if (permissionStatus.isPermanentlyDenied) {
      // Open app settings if permission is permanently denied
      openAppSettings();
    } else {
      // Permission denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photo access is required to select an image.')),
      );
    }
  }

  // Method to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }






  // Method to crop the image
  Future<void> _cropImage(String imagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _imageFile = File(croppedFile.path);
      });
    }
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker and Cropper'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(child: Text('No image selected')),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestPermissionAndPickImage,
              child: Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}
