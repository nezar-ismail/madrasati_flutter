import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:madrasati/presintation/core/utils/button_service.dart';
import 'package:madrasati/presintation/features/school_group/school_group.dart';
import 'package:madrasati/presintation/features/student/widgets/st_info.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // User Profile Section
          const ContainerStudentInfo(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Daily Progress Section

              //TODO: Add Progress Bar

              // Service Section (Buttons)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ButtonService(
                    onPressed: () {
                      log('Pressed School Group');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SchoolGroup()));
                    },
                    text: 'School Group',
                    color: Colors.blue,
                  ),
                  ButtonService(
                    onPressed: () {
                      log('Pressed Manaheg');
                    },
                    text: 'Manaheg',
                    color: Colors.orange,
                  ),
                ],
              )
            ],
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedLabelStyle: const TextStyle(color: Colors.blue, fontSize: 15),
        unselectedLabelStyle: const TextStyle(color: Colors.blue, fontSize: 15),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        iconSize: 35,


        backgroundColor: Colors.white,
        currentIndex: 0,
        onTap: (index) {
          log(index.toString());
          if (index == 0) {
            // Home
            // TODO: Navigate to Home
          } else if (index == 1) {
            // Profile
            // TODO: Navigate to Profile
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled,),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
