import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;




// class Salesreportpdf extends StatefulWidget {
  

//   final PdfGenerator pdfGenerator = PdfGenerator();

//   PurchasePage({super.key, required this.Purchase});

//   @override
//   State<PurchasePage> createState() => _PurchasePageState();
// }

// class _PurchasePageState extends State<PurchasePage> {
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: blue,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: const Icon(CupertinoIcons.back),
//           color: white,
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Payment Invoice',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           TextButton.icon(
//             onPressed: () async {
//               setState(() {
//                 _isLoading = true;
//               });

//               try {
//                 final pdfFile = await widget.pdfGenerator.generateReceiptPdf(
//                   receiptNumber: '12345',
//                   date: widget.Purchase.date,
//                   customerName: widget.Purchase.customerName,
//                   amount: double.parse(widget.Purchase.cash),
//                   paymentMode: widget.Purchase.paymentMethod,
//                   ProductName: widget.Purchase.product,
//                   quantity: widget.Purchase.quantity.toString(),
//                 );
//                 print("Path - ${pdfFile.path}");
//                 await Printing.layoutPdf(
//                   onLayout: (PdfPageFormat format) async =>
//                       pdfFile.readAsBytes(),
//                 );
//               } catch (e) {
//                 // Handle any errors here
//                 print('Error generating or printing PDF: $e');
//               } finally {
//                 setState(() {
//                   _isLoading = false;
//                 });
//               }
//             },
//             icon: const Icon(Icons.print, color: Colors.white),
//             label: const Text(
//               'Print',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CustomElevatedButton(
//               text: 'Generate Invoice',
//               onPressed: () async {
//                 setState(() {
//                   _isLoading = true;
//                 });

//                 try {
//                   final pdfFile = await widget.pdfGenerator.generateReceiptPdf(
//                     receiptNumber: '12345',
//                     date: widget.Purchase.date,
//                     customerName: widget.Purchase.customerName,
//                     amount: double.parse(widget.Purchase.cash),
//                     paymentMode: widget.Purchase.paymentMethod,
//                     ProductName: widget.Purchase.product,
//                     quantity: widget.Purchase.quantity.toString(),
//                   );
//                   print("Path - ${pdfFile.path}");
//                   await Printing.layoutPdf(
//                     onLayout: (PdfPageFormat format) async =>
//                         pdfFile.readAsBytes(),
//                   );
//                 } catch (e) {
//                   // Handle any errors here
//                   print('Error generating or printing PDF: $e');
//                 } finally {
//                   setState(() {
//                     _isLoading = false;
//                   });
//                 }
//               },
//             ),
//             Center(
//                 child: _isLoading
//                     ? const SpinningLinesExample()
                 

//                     : const Text("Print invoice")),
//           ]),
//     );
//   }
// }



















// class PdfGenerator {
//   Future<File> generateReceiptPdf(
//       {required String receiptNumber,
//       required String date,
//       required String customerName,
//       required double amount,
//       required String paymentMode,
//       required String ProductName,
//       required String quantity}) async {
//     final pdf = pw.Document();

//     // Load images from assets
//     final Uint8List logoBytes =
//         (await rootBundle.load('assets/images/qr.png')).buffer.asUint8List();
//     final Uint8List signatureBytes =
//         (await rootBundle.load('assets/images/seal.png')).buffer.asUint8List();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Text('Payment Receipt',
//                         style: pw.TextStyle(
//                             fontSize: 30, fontWeight: pw.FontWeight.bold)),
//                     pw.Image(pw.MemoryImage(logoBytes), width: 100),
//                   ],
//                 ),
//                 pw.Text('''ABC DIGITAL WORLD''',
//                     style: pw.TextStyle(
//                         fontSize: 22, fontWeight: pw.FontWeight.bold)),
//                 pw.Text('''Near MetroPiller 542
// Kadavantra 
// Contact Number : 9876543210''',
//                     style: pw.TextStyle(
//                         fontSize: 18, fontWeight: pw.FontWeight.normal)),
//                 pw.SizedBox(height: 20),
//                 pw.Text('Receipt Number: $receiptNumber',
//                     style: const pw.TextStyle(fontSize: 18)),
//                 pw.Text('Date: $date', style: const pw.TextStyle(fontSize: 18)),
//                 pw.Text('Customer Name: $customerName',
//                     style: const pw.TextStyle(fontSize: 18)),
//                 pw.SizedBox(height: 20),
//                 pw.Table(
//                   border: pw.TableBorder.all(),
//                   children: [
//                     pw.TableRow(children: [
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('Customer Name',
//                             style:
//                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('Product Name ',
//                             style:
//                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('Price',
//                             style:
//                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('Purchase Date',
//                             style:
//                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('Quantity',
//                             style:
//                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('Payment mode',
//                             style:
//                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                     ]),
//                     pw.TableRow(children: [
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text(customerName),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text(ProductName),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('\$$amount'),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text(date),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text(quantity),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text(paymentMode),
//                       ),
//                     ]),
//                     // Add more rows as needed
//                   ],
//                 ),
//                 pw.SizedBox(height: 20),
//                 pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.end,
//                   children: [
//                     pw.Text('Thank you for your business!',
//                         style: pw.TextStyle(
//                             fontSize: 16, fontStyle: pw.FontStyle.italic)),
//                     pw.SizedBox(width: 20),
//                     pw.Image(pw.MemoryImage(signatureBytes), width: .50.sw),
//                   ],
//                 ),
//               ],
//             ),
//           ); // Center
//         },
//       ),
//     );

//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/receipt.pdf");
//     await file.writeAsBytes(await pdf.save());

//     return file;
//   }
// }
