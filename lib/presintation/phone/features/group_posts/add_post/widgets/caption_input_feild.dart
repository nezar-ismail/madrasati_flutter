import 'package:flutter/material.dart';

class CaptionInputField extends StatelessWidget {
  final TextEditingController controller;

  const CaptionInputField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Write Something.....',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      maxLines: 3,
    );
  }
}

