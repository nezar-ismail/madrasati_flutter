import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:madrasati/presintation/core/utils/button_service.dart';
import 'package:madrasati/presintation/core/utils/progress_bar.dart';
import 'package:madrasati/presintation/features/student/widgets/st_info.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User Profile Section
              const ContainerStudentInfo(),
              // Daily Progress Section
              const ProgressBar(),
              // Service Section (Buttons)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ButtonService(
                    onPressed: () {
                      log('Pressed School Group');
                    },
                    text: 'School Group',
                    color: Colors.blue,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ButtonService(
                    onPressed: () {
                      log('Pressed Manaheg');
                    },
                    text: 'Manaheg',
                    color: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 0,
        onTap: (index) {
          log(index.toString());
          if (index == 0) {
            Colors.green;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, color: Colors.blueAccent, size: 35),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blueAccent, size: 35),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
