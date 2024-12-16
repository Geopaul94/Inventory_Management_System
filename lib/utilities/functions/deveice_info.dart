


//   import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<void> requestStoragePermission() async {
//   if (Platform.isAndroid) {
//     final androidInfo = await DeviceInfoPlugin().androidInfo;
//     if (androidInfo.version.sdkInt <= 32) {
//       // Request storage permission for Android versions <= 32
//       var status = await Permission.storage.status;
//       if (!status.isGranted) {
//         await Permission.storage.request();
//       }
//     } else {
//       // Request photo permission for Android versions > 32
//       var status = await Permission.photos.status;
//       if (!status.isGranted) {
//         await Permission.photos.request();
//       }
//     }
//   }
// }

