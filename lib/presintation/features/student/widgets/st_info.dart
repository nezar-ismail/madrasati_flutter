import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:madrasati/presintation/features/sign_in/role_desesion.dart';

class ContainerStudentInfo extends StatelessWidget {
  const ContainerStudentInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.30,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.lerp(
              const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(2),
              ),
              BorderRadius.vertical(bottom: Radius.circular(20)),
              6.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              const Color.fromARGB(255, 151, 196, 248)
            ],
          )),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 60, color: Colors.grey),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          const Padding(
            padding: EdgeInsets.only(top: 80.0, bottom: 10.0, left: 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'School Name',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Class Level',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0, left: 20.0),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none,
              ),
              iconSize: 50,
              color: Colors.white,
              hoverColor: Colors.orange,
              splashColor: Colors.green,
              onPressed: () {
                log('Notification Clicked');
                // Handle notification click
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              bottom: 160.0,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.height,
              child: IconButton(
                icon: const Icon(Icons.logout),
                iconSize: 30,
                color: const Color.fromARGB(255, 218, 157, 66),
                onPressed: () {
                  Navigator.push(
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
          ),
        ],
      ),
    );
  }
}
