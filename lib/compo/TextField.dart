import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  const TextForm(
      {super.key,
      required this.hint,
      required this.mycontroller,
      required this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: mycontroller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
