import 'package:flutter/material.dart';

Widget customTextFormField({
  required TextEditingController controller,
  required String hintText,
  required IconData prefixIcon,
  required FormFieldValidator<String> validator,
  
  bool obscureText = false,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon,
    ),
    validator: validator,
  );
}
