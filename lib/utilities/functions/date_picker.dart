// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';


// Future<String?> selectDateTime(BuildContext context) async {
//   // Show the date picker
//   DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2101),
//   );

//   if (pickedDate != null) {
//     // If the user picked a date, show the time picker
//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (pickedTime != null) {
//       // Combine the selected date and time
//       DateTime selectedDateTime = DateTime(
//         pickedDate.year,
//         pickedDate.month,
//         pickedDate.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );

//       // Format the date and time
//       String formattedDateTime =
//           DateFormat('dd-MMMM-yyy       ').format(selectedDateTime);
//           String formattedTime =
//           DateFormat('HH:mm      ').format(selectedDateTime);

//       return formattedDateTime   ; // Return the formatted date and time
//     }
//   }

//   return null; // If the user cancels, return null
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeResult {
  final String formattedDate;
  final String formattedTime;

  DateTimeResult({
    required this.formattedDate,
    required this.formattedTime,
  });
}

Future<DateTimeResult?> selectDateTime(BuildContext context) async {
  // Show the date picker
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null) {
    // If the user picked a date, show the time picker
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Combine the selected date and time
      DateTime selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Format the date and time
      String formattedDate = DateFormat('dd-MMMM-yyyy').format(selectedDateTime);
      String formattedTime = DateFormat('HH:mm').format(selectedDateTime);

      // Return both date and time in a custom object
      return DateTimeResult(
        formattedDate: formattedDate,
        formattedTime: formattedTime,
      );
    }
  }

  return null; // If the user cancels, return null
}
