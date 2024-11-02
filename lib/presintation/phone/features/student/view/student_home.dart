import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';
import 'package:madrasati/presintation/core/utils/button_service.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/school_group/school_group.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';
import 'package:madrasati/presintation/phone/features/student/widgets/st_info.dart';

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
              // Service Section (Buttons)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Services',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: scaleText(20, context),
                        fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<UserProfileCubit, LocalStudent?>(
                    builder: (context, user) {
                      return ButtonService(
                        onPressed: () {
                          log('Pressed School Group');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SchoolGroup(
                                        groupId: user?.groupId ?? '',
                                      )));
                        },
                        text: 'School Group',
                        color: Colors.blue,
                      );
                    },
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
        selectedLabelStyle:
            TextStyle(color: Colors.blue, fontSize: scaleText(15, context)),
        unselectedLabelStyle:
            TextStyle(color: Colors.blue, fontSize: scaleText(15, context)),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        selectedFontSize: scaleText(15, context),
        unselectedFontSize: scaleText(15, context),
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
              icon: Icon(
                Icons.home_filled,
              ),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
