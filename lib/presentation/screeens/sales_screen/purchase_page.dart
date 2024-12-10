import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/pdf_invoice.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/customanimation_explore_page_loading.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../utilities/constants/constants.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;


import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
// For File I/O operations

class PurchasePage extends StatefulWidget {
  final SalesDetailsModel Purchase;



  final PdfGenerator pdfGenerator = PdfGenerator();

  PurchasePage({super.key, required this.Purchase});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment Invoice',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });

              try {
                final pdfFile = await widget.pdfGenerator.generateReceiptPdf(
                  receiptNumber: '12345',
                  date: widget.Purchase.date,
                  customerName: widget.Purchase.customerName,
                  amount: double.parse(widget.Purchase.cash),
                  paymentMode: widget.Purchase.paymentMethod,
                  ProductName: widget.Purchase.product,
                  quantity: widget.Purchase.quantity.toString(),
                );
                print("Path - ${pdfFile.path}");
                await Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) async =>
                      pdfFile.readAsBytes(),
                );
              } catch (e) {
                // Handle any errors here
                print('Error generating or printing PDF: $e');
              } finally {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            icon: const Icon(Icons.print, color: Colors.white),
            label: const Text(
              'Print',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomElevatedButton(
              text: 'Generate Invoice',
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  final pdfFile = await widget.pdfGenerator.generateReceiptPdf(
                    receiptNumber: '12345',
                    date: widget.Purchase.date,
                    customerName: widget.Purchase.customerName,
                    amount: double.parse(widget.Purchase.cash),
                    paymentMode: widget.Purchase.paymentMethod,
                    ProductName: widget.Purchase.product,
                    quantity: widget.Purchase.quantity.toString(),
                  );
                  print("Path - ${pdfFile.path}");
                  await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async =>
                        pdfFile.readAsBytes(),
                  );
                } catch (e) {
                  // Handle any errors here
                  print('Error generating or printing PDF: $e');
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
            h50,
            CustomElevatedButton(
              text: 'Generate Excel sheet',
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                try {
               generateAndSaveExcel();

                //  _excelFAB();
                } catch (e) {
                  // Handle any errors here
                  print('Error generating in excel sheet: $e');
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
            Center(
                child: _isLoading
                    ? const SpinningLinesExample()
                    : const Text("Print invoice")),
          ]),
    );
  }


Future<void> generateAndSaveExcel() async {
  print('Allowing user to choose the file saving location');
  
  // Define the directory path (Download folder)
  final directory = Directory("/storage/emulated/0/Download");

  // Define the full path to save the Excel file
  String filePath = '${directory.path}/${widget.Purchase.customerName}.xlsx'; 

  // Check if the directory exists, and if not, create it
  if (!(await directory.exists())) {
    await directory.create(recursive: true);
    print('Directory created: ${directory.path}');
  }

  // Create a new Excel workbook and worksheet
  final xcel.Workbook workbook = xcel.Workbook();
  final xcel.Worksheet sheet = workbook.worksheets[0]; // First sheet

  // Set the file name based on the customer's name
  String excelFile = '${widget.Purchase.customerName.toString()}.xlsx'; 

  // Populate the Excel sheet with data from SalesDetailsModel
  sheet.getRangeByIndex(1, 1).setText('Customer Name');
  sheet.getRangeByIndex(1, 2).setText(widget.Purchase.customerName.toString());

  sheet.getRangeByIndex(2, 1).setText('Product Category');
  sheet.getRangeByIndex(2, 2).setText(widget.Purchase.productCategory.toString());

  sheet.getRangeByIndex(3, 1).setText('Product');
  sheet.getRangeByIndex(3, 2).setText(widget.Purchase.product.toString());

  sheet.getRangeByIndex(4, 1).setText('Quantity');
  sheet.getRangeByIndex(4, 2).setText(widget.Purchase.quantity.toString());

  sheet.getRangeByIndex(5, 1).setText('Date');
  sheet.getRangeByIndex(5, 2).setText(widget.Purchase.date.toString());

  sheet.getRangeByIndex(6, 1).setText('Time');
  sheet.getRangeByIndex(6, 2).setText(widget.Purchase.Time.toString());

  sheet.getRangeByIndex(7, 1).setText('Payment Method');
  sheet.getRangeByIndex(7, 2).setText(widget.Purchase.paymentMethod.toString());

  sheet.getRangeByIndex(8, 1).setText('Cash');
  sheet.getRangeByIndex(8, 2).setText(widget.Purchase.cash.toString());

  // Save the Excel workbook as a stream of bytes
  final List<int> bytes = workbook.saveAsStream();

  // Create the file object for the Excel file
  final file = File(filePath);

  print('Saving Excel file to: ${file.path}');

  // Write the bytes to the file
  await file.writeAsBytes(bytes);

  // Show a success message to the user
  Fluttertoast.showToast(
    msg: 'Excel file successfully saved to: ${file.path}',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
  );

  // Dispose of the workbook to release memory
  workbook.dispose();
}
}