
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class Passwordtextformfield extends StatefulWidget {
  const Passwordtextformfield({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
    this.margin,
    this.keyboardType,
    // this.obscureText = false,
    this.validator,
  });

  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  // final bool obscureText;
  final FormFieldValidator<String>? validator;

  @override
  State<Passwordtextformfield> createState() => _PasswordtextformfieldState();
}

bool isObsecure = true;

class _PasswordtextformfieldState extends State<Passwordtextformfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.all(0),
      child: StatefulBuilder(
        builder: (context, setState) {
          // bool isObscure = isObsecure;
          return TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: isObsecure,
            validator: widget.validator,
            decoration: InputDecoration(
              labelText: widget.hintText,
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
              suffixIcon: IconButton(
                icon: Icon(
                  isObsecure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: textFieldBorderColor, width: 2.0),
                borderRadius: kradius20,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: kradius20,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: kradius20,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.redAccent, width: 2.0),
                borderRadius: kradius20,
              ),
            ),
          );
        },
      ),
    );
  }
}
