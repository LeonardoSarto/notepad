import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String hintText;
  final int? maxLines;
  final String? initialValue;

  const CustomTextFormField(
      {super.key,
      this.onSaved,
      this.validator,
      required this.hintText,
      this.maxLines,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color.fromARGB(200, 124, 112, 29)),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        decoration: InputDecoration(hintText: hintText),
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}
