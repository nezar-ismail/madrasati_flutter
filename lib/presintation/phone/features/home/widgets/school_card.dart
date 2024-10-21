import 'package:flutter/material.dart';
import 'package:madrasati/presintation/phone/features/home/widgets/school_card_info.dart';

class SchoolCard extends StatelessWidget {
  const SchoolCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      margin:const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage('asset/static/image/school.png'), fit: BoxFit.contain),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      )
      ,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Colors.transparent,
              Colors.white12,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: const SchoolCardInfo(),
        ),
      ),
    );
  }
}

