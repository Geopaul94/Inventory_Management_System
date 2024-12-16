// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:excel/excel.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';

// import 'package:inventory_management_system/data/models/sales_model.dart';
// import 'package:inventory_management_system/presentation/bloc/sales_bloc/sales_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ExportToExcelPage extends StatefulWidget {
//   const ExportToExcelPage({Key? key}) : super(key: key);

//   @override
//   State<ExportToExcelPage> createState() => _ExportToExcelPageState();
// }

// class _ExportToExcelPageState extends State<ExportToExcelPage> {
//   bool _isLoading = false;
// Future<File> generateExcel(List<SalesDetailsModel> salesData) async {
//   try {
//     // Create a new Excel workbook
//     final Excel excel = Excel.createExcel();
    
//     // Remove the default sheet and create a new one
//     excel.delete('Sheet1');
//     final Sheet sheet = excel.createSheet('SalesData');

//     // Define headers
//     _safeSetCellValue(sheet, 'A1', 'Sale ID');
//     _safeSetCellValue(sheet, 'B1', 'Date');
//     _safeSetCellValue(sheet, 'C1', 'Customer Name');
//     _safeSetCellValue(sheet, 'D1', 'Amount');
//     _safeSetCellValue(sheet, 'E1', 'Payment Mode');
//     _safeSetCellValue(sheet, 'F1', 'Product Name');
//     _safeSetCellValue(sheet, 'G1', 'Quantity');
//     _safeSetCellValue(sheet, 'H1', 'Time');
//     _safeSetCellValue(sheet, 'I1', 'Category');
//     _safeSetCellValue(sheet, 'J1', 'Created At');

//     // Populate sheet with sales data
//     for (int i = 0; i < salesData.length; i++) {
//       var sale = salesData[i];
      
//       _safeSetCellValue(sheet, 'A${i + 2}', sale.saleId ?? '');
//       _safeSetCellValue(sheet, 'B${i + 2}', sale.date ?? '');
//       _safeSetCellValue(sheet, 'C${i + 2}', sale.customerName ?? '');
//       _safeSetCellValue(sheet, 'D${i + 2}', sale.cash ?? 0.0);
//       _safeSetCellValue(sheet, 'E${i + 2}', sale.paymentMethod ?? '');
//       _safeSetCellValue(sheet, 'F${i + 2}', sale.product ?? '');
//       _safeSetCellValue(sheet, 'G${i + 2}', sale.quantity ?? 0);
//       _safeSetCellValue(sheet, 'H${i + 2}', sale.Time ?? '');
//       _safeSetCellValue(sheet, 'I${i + 2}', sale.category ?? '');
//       _safeSetCellValue(sheet, 'J${i + 2}', 
//         sale.createdAt != null ? sale.createdAt.toDate().toString() : '');
//     }

//     // Save the file
//     final directory = await getApplicationDocumentsDirectory();
//     final path = '${directory.path}/SalesData.xlsx';
    
//     // Encode and write the file
//     final List<int>? fileBytes = excel.save();
//     if (fileBytes != null) {
//       final File file = File(path)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(fileBytes);
//       return file;
//     } else {
//       throw Exception('Failed to generate Excel file: No file bytes');
//     }
//   } catch (e) {
//     print('Excel generation error: $e');
//     throw Exception('Failed to generate Excel file: $e');
//   }
// }

// // Safe cell value setting method
// void _safeSetCellValue(Sheet sheet, String cellReference, dynamic value) {
//   try {
//     final cell = sheet.cell(CellIndex.indexByString(cellReference));
    
//     // Handle different types of values
//     if (value == null) {
//       cell.value = '';
//     } else if (value is String) {
//       cell.value = value;
//     } else if (value is num) {
//       cell.value = value;
//     } else if (value is bool) {
//       cell.value = value;
//     } else {
//       // Convert to string as a last resort
//       cell.value = value.toString() as CellValue?;
//     }
//   } catch (e) {
//     print('Error setting cell value for $cellReference: $e');
//     // Optionally log the error or handle it as needed
//   }
// }
// }