import 'package:flutter/material.dart';

class CustomBotton extends StatefulWidget {
  String text;

  CustomBotton({
    super.key,
    required this.text,
  });

  @override
  State<CustomBotton> createState() => _CustomBottonState();
}

class _CustomBottonState extends State<CustomBotton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
