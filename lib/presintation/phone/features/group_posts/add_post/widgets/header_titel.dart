import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Add Post',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
