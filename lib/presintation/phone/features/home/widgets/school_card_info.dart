import 'package:flutter/material.dart';

class SchoolCardInfo extends StatelessWidget {
  const SchoolCardInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'School Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
            Text(
              'Middle School',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.height * 0.015,
              ),
            ),
          ],
        ),
        const Row(
          children: [
            Text('4.3',
                style: TextStyle(
              
              fontFamily: 'Roboto',
              
            )),
            Icon(Icons.star, color: Colors.amber),
          ],
        ),
      ],
    );
  }
}