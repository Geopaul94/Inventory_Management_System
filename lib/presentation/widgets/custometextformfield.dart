import 'package:flutter/material.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final Color errorTextColor;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextInputType keyboardType;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final TextStyle? errorTextStyle;
  final Color labelTextColor;
  final Color hintTextColor;
  final double? height; // Optional height
  final double? width; // Optional width
  final int? maxLines; // Optional max lines
  final int? minLines; // Optional min lines
  final int? maxWordCount; // Optional max word count
  final TextAlign textAlign; // Text alignment for the input text and hint text
  final bool? readOnly;
  final GestureTapCallback? onTap; 
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.errorBorderColor = red,
    this.focusedErrorBorderColor = Colors.green,
    this.errorTextStyle,
    this.labelTextColor = Colors.black,
    this.hintTextColor = Colors.grey, // Default hint text color is grey
    this.errorTextColor = red,
    this.height,
    this.width,
    this.maxLines,
    this.minLines,
    this.maxWordCount,
    this.textAlign = TextAlign.left,
    this.readOnly = false,
    this.onTap,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  String? _validateWordCount(String? value) {
    if (widget.maxWordCount != null && value != null) {
      int wordCount = value.split(RegExp(r'\s+')).length;
      if (wordCount > widget.maxWordCount!) {
        return 'Maximum word count is ${widget.maxWordCount}';
      }
    }
    return null; // No error
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height, // This can be set to null if using min/maxLines
      width: widget.width,
      child: TextFormField(
        readOnly: widget.readOnly ?? false, // Handle readOnly if provided
        onTap: widget.onTap,
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        textAlign: widget.textAlign, // Apply the text alignment here
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0), // Padding for better appearance
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          errorStyle: TextStyle(color: widget.errorTextColor),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: widget.hintTextColor), // Set hint text color here
          labelStyle: TextStyle(color: widget.labelTextColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: green),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.errorBorderColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.focusedErrorBorderColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          return _validateWordCount(value) ?? widget.validator?.call(value);
        },
      ),
    );
  }
}
