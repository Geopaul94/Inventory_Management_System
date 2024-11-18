
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethodSelectionField extends StatelessWidget {
  final TextEditingController controller;
  final List<String> paymentMethods;
  final String labelText;

  PaymentMethodSelectionField({
    required this.controller,
    required this.paymentMethods,
    this.labelText = '', // Default label
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true, // Make it read-only since it is for displaying the selected option
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),prefixIcon: Icon(CupertinoIcons.qrcode_viewfinder),
        suffixIcon: PopupMenuButton<String>(
          icon: Icon(Icons.arrow_drop_down),
          onSelected: (String value) {
            controller.text = value; // Update the TextFormField with the selected option
          },


          
          itemBuilder: (BuildContext context) {
            return paymentMethods.map((String method) {
              return PopupMenuItem<String>(
                value: method,
                child: Text(method),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}