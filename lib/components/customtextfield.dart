import 'package:flutter/material.dart';

class CustomTextFiels extends StatefulWidget {
  String text;
  String title;
  TextEditingController? controller;
  final obscure;
  final icon;
  final suicon;

  CustomTextFiels(
      {super.key,
      required this.text,
      required this.controller,
      required this.obscure,
      required this.icon,
      required this.title,
      required this.suicon});

  @override
  State<CustomTextFiels> createState() => _CustomTextFielsState();
}

class _CustomTextFielsState extends State<CustomTextFiels> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscure,
      validator: (value) {
        if (value!.isEmpty) {
          return widget.title;
        }
        return null;
      },
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: const TextStyle(color: Colors.blueAccent),
          prefixIcon: widget.icon,
          suffixIcon: widget.suicon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueAccent),
          )),
    );
  }
}
