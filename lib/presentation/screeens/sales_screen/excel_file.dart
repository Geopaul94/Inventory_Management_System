// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
// import 'package:path_provider/path_provider.dart';

// import 'package:permission_handler/permission_handler.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// // For File I/O operations

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List results = Results.results;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         toolbarHeight: 60,
//         title: Text(
//           'All Students',
//           style: GoogleFonts.montserrat(
//             textStyle: Theme.of(context).textTheme.headlineMedium,
//             fontWeight: FontWeight.w400,
//             fontSize: 22.0,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20)),
//             color: Colors.blue,
//           ),
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: ListView.separated(
//           itemCount: results.length,
//           itemBuilder: (BuildContext context, index) {
//             return InkWell(
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).push(
//                   MaterialPageRoute(
//                     builder: (_) => StudentProfile(
//                       studentName: results[index][0],
//                       studentReg: results[index][1],
//                       studentImage: results[index][2],
//                       studentResults: results[index][3],
//                     ),
//                   ),
//                 );

//                 print("   studentName: ${results[index][0]},");

//                 print("   studentReg: ${results[index][1]},");

//                 print("   studentImage: ${results[index][2]},");

//                 print("   studentResults: ${results[index][3]},");
//               },
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: AssetImage(results[index][2]),
//                 ),
//                 title: Text(
//                   results[index][0],
//                   style: const TextStyle(fontSize: 14),
//                 ),
//                 subtitle: Text(
//                   results[index][1],
//                   style: const TextStyle(fontSize: 13),
//                 ),
//               ),
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) {
//             return const Divider();
//           },
//         ),
//       ),
//       floatingActionButton: _excelFAB(),
//     );
//   }

//   Widget _excelFAB() {
//     return FloatingActionButton(
//       onPressed: () {
//         generateAndSaveExcel();
//         print('generate excel sheet pressed');
//       },
//       backgroundColor: Colors.green,
//       child: const Icon(
//         CupertinoIcons.tray_arrow_down,
//         color: Colors.white,
//       ),
//     );
//   }

//   Future<void> generateAndSaveExcel() async {
//     print('Requesting storage permissions');
//     // Request storage permissions
//     var status = await Permission.storage.request();
//     var manageStatus = await Permission.manageExternalStorage.request();
//     bool v = true;

//     if (v) {
//       // Permissions granted
//       print('Storage permissions granted');

//       // Create a new Excel workbook and worksheet
//       final xcel.Workbook workbook = xcel.Workbook();
//       final xcel.Worksheet sheet = workbook.worksheets[0]; // First sheet
//       const String excelFile = 'students_report.xlsx'; // Name of the Excel file

//       // Populate the Excel sheet with data
//       sheet.getRangeByIndex(1, 1).setText('All Students');
//       sheet.getRangeByIndex(2, 1).setText('Form 4 West'); // Example class
//       sheet.getRangeByIndex(4, 1).setText('Student Name');
//       sheet.getRangeByIndex(4, 2).setText('Maths');
//       sheet.getRangeByIndex(4, 3).setText('English');
//       // Add more columns and data...

//       // Loop through the results to set data in the Excel sheet cells
//       for (var i = 0; i < results.length; i++) {
//         sheet.getRangeByIndex(i + 5, 1).setText(results[i][0]);
//         sheet
//             .getRangeByIndex(i + 5, 2)
//             .setText(results[i][3]['Maths'][0].toString());
//         sheet
//             .getRangeByIndex(i + 5, 3)
//             .setText(results[i][3]['English'][0].toString());
//         // Add more subjects...
//       }

//       // Save the Excel workbook as a stream of bytes
//       final List<int> bytes = workbook.saveAsStream();

//       // Get the application documents directory to save the file
//  //     final directory = await getApplicationDocumentsDirectory();

// final  file = await  File("/storage/emulated/0/Download/$excelFile");

//       // final file = File(
//       //     "${directory.path}/$excelFile"); // Save the file in the documents directory

//       print('Saving Excel file to: ${file.path}');

//       // Write the bytes to the file
//       await file.writeAsBytes(bytes);

//       // Show a success message to the user
//       Fluttertoast.showToast(
//         msg: 'Excel file successfully saved to: ${file.path}',
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.blue,
//         textColor: Colors.white,
//       );

//       // Dispose of the workbook to release memory
//       workbook.dispose();
//     }
//   }
// }
