import 'package:flutter/material.dart';

import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';

import 'package:printing/printing.dart';

class ItemsReportTab extends StatefulWidget {
  const ItemsReportTab({super.key});

  @override
  State<ItemsReportTab> createState() => _ItemsReportTabState();
}

class _ItemsReportTabState extends State<ItemsReportTab> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  DateTime? _fromDate;
  DateTime? _toDate;

  Future<void> selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          _fromDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          _toDate = picked;
          _toDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  Future<void> fetchSalesData() async {
    if (_fromDate != null && _toDate != null) {
      String fromDateString = DateFormat('dd-MMMM-yyyy').format(_fromDate!);
      String toDateString = DateFormat('dd-MMMM-yyyy').format(_toDate!);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('sales')
          .where('date', isGreaterThanOrEqualTo: fromDateString)
          .where('date', isLessThanOrEqualTo: toDateString)
          .get();

      List<SalesDetailsModel> salesDetails = querySnapshot.docs.map((doc) {
        return SalesDetailsModel.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();

      Map<String, double> totalCashByCategory = {};
      Map<String, int> totalQuantityByCategory = {};

      for (var sale in salesDetails) {
        String category = sale.productCategory;

        totalCashByCategory[category] =
            (totalCashByCategory[category] ?? 0) + double.parse(sale.cash);
        totalQuantityByCategory[category] =
            (totalQuantityByCategory[category] ?? 0) + sale.quantity;
      }

      double totalCash =
          totalCashByCategory.values.fold(0, (sum, cash) => sum + cash);

      // Show dialog with summary and print button
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sales Summary'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...totalCashByCategory.entries.map((entry) => Text(
                      '${entry.key} - Total Cash: \$${entry.value.toStringAsFixed(2)}, Total Quantity: ${totalQuantityByCategory[entry.key]}',
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  PdfGeneratorsalesreport pdfGenerator =
                      PdfGeneratorsalesreport();
                  File pdfFile = await pdfGenerator.generateReceiptPdf(
                    receiptNumber: 'Receipt #12345',
                    fromdate: fromDateString,
                    toDate: toDateString,
                    amount: totalCash,
                    productCategory: totalQuantityByCategory.keys.join(', '),
                    quantity: totalQuantityByCategory.values
                        .fold(0, (sum, qty) => sum + qty)
                        .toString(),
                  );
                  print("Path - ${pdfFile.path}");
                  await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async =>
                        pdfFile.readAsBytes(),
                  );
                } catch (e) {
                  // Handle any errors here
                  print('Error generating or printing PDF: $e');
                }
              },
              child: const Text('Print'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both from and to dates')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _fromDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'From Date',
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => selectDate(context, true),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _toDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'To Date',
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => selectDate(context, false),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: fetchSalesData,
            child: const Text('Fetch Sales Data'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }
}

class PdfGeneratorsalesreport {
  Future<File> generateReceiptPdf({
    required String receiptNumber,
    required String fromdate,
    required String toDate,
    required double amount,
    required String productCategory,
    required String quantity,
  }) async {
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
                    pw.Text('Sales Report',
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
                pw.Text('From Date: $fromdate',
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text('To Date: $toDate',
                    style: const pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 20),
                // Create a table with sales details
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    // Table headers
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Product Category',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Sold Quantity',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Total Price',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ]),
                    // Data row
                    pw.TableRow(children: [
                      // Assuming productCategory is passed correctly
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(productCategory),
                      ),
                      // Use actual quantity here
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(quantity),
                      ),
                      // Use actual amount here
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('\$$amount'),
                      ),
                    ]),
                  ],
                ),
                // Thank you message and signature image...
                // Additional content can go here...
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/receipt.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
