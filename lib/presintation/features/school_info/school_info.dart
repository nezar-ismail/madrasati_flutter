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
            Icon(Icons.phone, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Text('0780840895'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Text('Amman, Jabal-altaj'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.star, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Text('4.3 from 4 raters'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.people, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Text('268 students'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.email, color: Colors.grey),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Text('schoolname@gmail.com'),
          ],
        ),
      ],
    );
  }
}