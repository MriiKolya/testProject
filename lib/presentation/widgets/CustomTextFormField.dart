// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.textEditingController,
    this.prefix,
    this.suffix,
    this.formKey,
    this.validator,
  });

  final String labelText;
  final TextEditingController textEditingController;
  final Widget? prefix;
  final Widget? suffix;
  final GlobalKey? formKey;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        validator: validator,
        key: formKey,
        controller: textEditingController,
        style: Theme.of(context).textTheme.labelLarge,
        decoration: InputDecoration(
          prefix: prefix,
          suffix: suffix,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300)),
          labelText: labelText,
        ),
      ),
    );
  }
}
