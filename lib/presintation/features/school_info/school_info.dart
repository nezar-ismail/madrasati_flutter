import 'package:flutter/material.dart';

class SchoolInfo extends StatelessWidget {
  const SchoolInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            const Text('0780840895'),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            const Text('Amman, Jabal-altaj'),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            const Text('4.3 from 4 raters'),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.people, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            const Text('268 students'),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.email, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            const Text('schoolname@gmail.com'),
          ],
        ),
      ],
    );
  }
}