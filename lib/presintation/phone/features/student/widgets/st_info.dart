import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:madrasati/presintation/phone/features/sign_in/role_desesion.dart';

class ContainerStudentInfo extends StatelessWidget {
  const ContainerStudentInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.lerp(
              const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(2),
              ),
              const BorderRadius.vertical(bottom: Radius.circular(20)),
              6.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              const Color.fromARGB(255, 151, 196, 248)
            ],
          )),

      // User Info
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 60, color: Colors.grey),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 80.0, bottom: 10.0, left: 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Name',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'School Name',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white),
                ),
                Text(
                  'Class Level',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white),
                ),
              ],
            ),
          ),

          //Notification
          //TODO: Add Notification

          FittedBox(
            fit: BoxFit.contain,
            child: IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 40,
              color: Colors.orange,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoleDesesion(),
                  ),
                );
                log('Logout Clicked');
                // Handle Logout click
              },
            ),
          ),
        ],
      ),
    );
  }
}
