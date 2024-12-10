import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
// For File I/O operations










class PdfGenerator {
  Future<File> generateReceiptPdf(
      {required String receiptNumber,
      required String date,
      required String customerName,
      required double amount,
      required String paymentMode,
      required String ProductName,
      required String quantity}) async {
    final pdf = pw.Document();

    // Load images from assets
    final Uint8List logoBytes =
        (await rootBundle.load('assets/images/qr.png')).buffer.asUint8List();
    final Uint8List signatureBytes =
        (await rootBundle.load('assets/images/seal.png')).buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Payment Receipt',
                        style: pw.TextStyle(
                            fontSize: 30, fontWeight: pw.FontWeight.bold)),
                    pw.Image(pw.MemoryImage(logoBytes), width: 100),
                  ],
                ),
                pw.Text('''ABC DIGITAL WORLD''',
                    style: pw.TextStyle(
                        fontSize: 22, fontWeight: pw.FontWeight.bold)),
                pw.Text('''Near MetroPiller 542
Kadavantra 
Contact Number : 9876543210''',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.normal)),
                pw.SizedBox(height: 20),
                pw.Text('Receipt Number: $receiptNumber',
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text('Date: $date', style: const pw.TextStyle(fontSize: 18)),
                pw.Text('Customer Name: $customerName',
                    style: const pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 20),
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Customer Name',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Product Name ',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Price',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Purchase Date',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Quantity',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Payment mode',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(customerName),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(ProductName),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('\$$amount'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(date),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(quantity),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(paymentMode),
                      ),
                    ]),
                    // Add more rows as needed
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text('Thank you for your business!',
                        style: pw.TextStyle(
                            fontSize: 16, fontStyle: pw.FontStyle.italic)),
                    pw.SizedBox(width: 20),
                    pw.Image(pw.MemoryImage(signatureBytes), width: .50.sw),
                  ],
                ),
              ],
            ),
          ); // Center
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/receipt.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}















// For File I/O operations

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
