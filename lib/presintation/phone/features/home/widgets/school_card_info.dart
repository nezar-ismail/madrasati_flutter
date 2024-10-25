import 'package:flutter/material.dart';

class SchoolCardInfo extends StatelessWidget {
  final String schoolName;
  final String schoolType;
  final double rating;

  const SchoolCardInfo({
    super.key,
    required this.schoolName,
    required this.schoolType,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      
      decoration: BoxDecoration(
        color: const Color.fromARGB(199, 255, 255, 255),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10) ),),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                schoolName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                ),
              ),
              Text(
                schoolType,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                rating.toString(),
                style: const TextStyle(
                  fontFamily: 'Roboto',
                ),
              ),
              const Icon(Icons.star, color: Colors.amber),
            ],
          ),
        ],
      ),
    );
  }
}
