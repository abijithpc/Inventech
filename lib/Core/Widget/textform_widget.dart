import 'package:flutter/material.dart';

Widget customTextFormField({
  required TextEditingController controller,
  required String hintText,
  required IconData prefixIcon,
  required FormFieldValidator<String> validator,
  Color? colors,
  bool obscureText = false,
  Widget? suffixIcon,
  double verticalPadding = 16.0,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      fillColor: colors,
      border: const OutlineInputBorder(),
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon,
    ),
    validator: validator,
  );
}
