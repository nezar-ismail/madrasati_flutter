import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.role,
    required this.image,
    required this.color,
    required this.borderColor,
  });
  final String role;
  final String image;
  final Color color;
  final Color borderColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(
            flex: 1,
          ),
          RoleImage(color: color, image: image, borderColor: borderColor),
          const Spacer(
            flex: 3,
          ),
          Text(role,
              style: const TextStyle(
                fontSize: 25,
              )),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}

class RoleImage extends StatelessWidget {
  const RoleImage({
    super.key,
    required this.color,
    required this.image,
    required this.borderColor,
  });

  final Color color;
  final String image;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        image: DecorationImage(
            image: AssetImage(image), fit: BoxFit.contain),
      ),
    );
  }
}
