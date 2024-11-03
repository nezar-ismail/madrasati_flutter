
import 'package:flutter/material.dart';

class DetailesBody extends StatelessWidget {
  const DetailesBody({
    super.key,
    required this.caption,
    required this.withImage,
  });

  final String caption;
  final bool withImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          if (!withImage)
            Image.asset(
              'asset/static/image/school.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}