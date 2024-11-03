
import 'package:flutter/material.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({super.key, required this.postCreatedAt});
  final String postCreatedAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[50],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'asset/static/image/school.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'School Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Posted in ${postCreatedAt.substring(0, 16).replaceAll('-', '/').replaceAll('T', ' - At ')}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}