import 'package:flutter/material.dart';

class TeacherStaff extends StatelessWidget {
  const TeacherStaff({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              'https://via.placeholder.com/100'), // Replace with actual image
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              'https://via.placeholder.com/100'), // Replace with actual image
        ),
        SizedBox(width: 10),
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              'https://via.placeholder.com/100'), // Replace with actual image
        ),
      ],
    );
  }
}