import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const Button({super.key, this.onPressed, required this.title});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color.fromARGB(255, 18, 106, 178),
      textColor: Colors.white,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
