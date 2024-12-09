import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:permission_handler/permission_handler.dart';

class ExcelsheetScreen extends StatefulWidget {
  const ExcelsheetScreen({super.key});

  @override
  State<ExcelsheetScreen> createState() => _ExcelsheetScreenState();
}

class _ExcelsheetScreenState extends State<ExcelsheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomElevatedButton(
          text: "Fetch Excel Data",
          onPressed: createExcel,
          height: 0.06.sh,
          width: 0.4.sw,
          fontSize: 14.sp,
        ),
      ),
    );
  }
Future<void> createExcel() async {
  if (await _requestPermission()) {
    // Create a new Excel document
    final xls.Workbook workbook = xls.Workbook();
    final xls.Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('Hello World!');

    // Save the document as a byte stream
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // Get the app's internal storage directory
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final String fileName = '$path/Output.xlsx';

    // Write the file to internal storage
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);

    // Open the file using the platform's file handler
    OpenFile.open(fileName);
  } else {
    print("Permission denied");
  }
}
Future<bool> _requestPermission() async {
  if (Platform.isAndroid) {
    // Android SDK 30+ needs different permissions
    if (await Permission.storage.isGranted) {
      return true;
    } else {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      }
    }
  }
  return false;
}

}