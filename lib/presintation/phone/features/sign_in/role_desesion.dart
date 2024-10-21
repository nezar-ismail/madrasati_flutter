import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:madrasati/presintation/core/utils/role_card.dart';
import 'package:madrasati/presintation/phone/features/home/home.dart';
import 'package:madrasati/presintation/phone/features/sign_in/model/role_card.dart';
import 'package:madrasati/presintation/phone/features/sign_in/school_sign_in.dart';
import 'package:madrasati/presintation/phone/features/sign_in/student_sign_in.dart';

class RoleDesesion extends StatelessWidget {
  RoleDesesion({super.key});

  final List<RoleCardInfo> roles = <RoleCardInfo>[
    RoleCardInfo(
      image: 'asset/static/image/geust.png',
      role: 'Geust',
      color: Colors.white,
    ),
    RoleCardInfo(
      image: 'asset/static/image/student.png',
      role: 'Student',
      color: Colors.white,
    ),
    RoleCardInfo(
      image: 'asset/static/image/school.png',
      role: 'School',
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Scaling factor for responsive text
    double scaleText(double size) {
      return size * textScaleFactor;
    }

    // ValueNotifier to manage selected role index
    final ValueNotifier<int> selectedRoleIndex = ValueNotifier<int>(-1);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ValueListenableBuilder<int>(
                    valueListenable: selectedRoleIndex,
                    builder: (context, index, child) {
                      return Text(
                        'Welcome',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: scaleText(30), // Responsive font size
                          color: index == -1
                              ? Colors.red
                              : index == 0
                                  ? Colors.orange
                                  : index == 1
                                      ? Colors.blue
                                      : Colors.green,
                        ),
                      );
                    }),
                Text(
                  'In Madrasati Application',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: scaleText(20), // Responsive font size
                  ),
                ),
                SizedBox(
                    height: size.height * 0.02), // Responsive height spacing
                ValueListenableBuilder<int>(
                  valueListenable: selectedRoleIndex,
                  builder: (context, index, child) {
                    return Column(
                      children: List.generate(roles.length, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              selectedRoleIndex.value =
                                  i; // Update selected card
                              log(roles[i].role);
                            },
                            child: RoleCard(
                              role: roles[i].role,
                              image: roles[i].image,
                              color: index == i && roles[i].role == 'Geust'
                                  ? Colors.orange
                                  : index == i && roles[i].role == 'Student'
                                      ? Colors.blue
                                      : index == i && roles[i].role == 'School'
                                          ? Colors.green
                                          : Colors.white,
                              borderColor: index == i &&
                                      roles[i].role == 'Geust'
                                  ? Colors.orange
                                  : index == i && roles[i].role == 'Student'
                                      ? Colors.blue
                                      : index == i && roles[i].role == 'School'
                                          ? Colors.green
                                          : Colors.grey,
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                SizedBox(
                    height: size.height * 0.02), // Responsive height spacing
                ValueListenableBuilder<int>(
                    valueListenable: selectedRoleIndex,
                    builder: (context, index, child) {
                      if (index == -1) {
                        return const Text(
                          'Please select a role',
                          style: TextStyle(
                              color: Colors.red, fontFamily: 'Roboto'),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the next screen
                            if (selectedRoleIndex.value == 0) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            } else if (selectedRoleIndex.value == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentSignIn()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SchoolSignIn()));
                            }
                          },
                          child: Container(
                            width: size.width * 0.6, // Responsive width
                            height: size.height * 0.06, // Responsive height
                            decoration: BoxDecoration(
                              color: index == 0 && roles[0].role == 'Geust'
                                  ? Colors.orange
                                  : index == 1 && roles[1].role == 'Student'
                                      ? Colors.blue
                                      : index == 2 && roles[2].role == 'School'
                                          ? Colors.green
                                          : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize:
                                      scaleText(20), // Responsive font size
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
