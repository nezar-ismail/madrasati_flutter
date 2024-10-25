import 'package:flutter/material.dart';

class TeacherStaff extends StatelessWidget {
  const TeacherStaff({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white, // Replace with actual image
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        const CircleAvatar(
          radius: 25,
         backgroundColor: Colors.white, // Replace with actual image
        ),
        const SizedBox(width: 10),
        const CircleAvatar(
          radius: 25,
           backgroundColor: Colors.white,  // Replace with actual image
        ),
      ],
    );
  }
}