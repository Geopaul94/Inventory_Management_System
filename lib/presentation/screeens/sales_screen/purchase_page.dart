import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/pdf_invoice.dart';
import 'package:inventory_management_system/presentation/widgets/customanimation_explore_page_loading.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../utilities/constants/constants.dart';



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
      body: Center(
        child: _isLoading
            ? SpinningLinesExample()
      //                 : Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: [
               
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                         children: [
      //                           CustomElevatedButton(
      //                               text: "Edit",
      //                               width: .20.sw,
      //                               height: 0.07.sh,
      //                               fontSize: 16.sp,
      //                               color: blue,
      //                               onPressed: () {
      //                                 Navigator.push(context, MaterialPageRoute(
      //                                   builder: (context) {
      //                                     return UpdatesalePage(
      //                                         updatesaledata: widget.Purchase);
      //                                   },
      //                                 ));
      //                               }),
      //                           CustomElevatedButton(
      //                               text: "Delete",
      //                               width: .20.sw,
      //                               height: 0.07.sh,
      //                               fontSize: 14.sp,
      //                               color: red,
      //                               onPressed: () {}),
      //                           CustomElevatedButton(
      //                               text: "Print",
      //                               width: .20.sw,
      //                               height: 0.07.sh,
      //                               fontSize: 14.sp,
      //                               color: blue,
      //                               onPressed: () 
      
      // async {
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
      
      
      
      //                               }),
      //                         ],
      //                       )
      //                     ],
      //                   ),
      
      :Text("Print invoice")
      
      ),
    );
  }
}
