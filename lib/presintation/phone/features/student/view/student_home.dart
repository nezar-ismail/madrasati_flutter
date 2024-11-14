import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/hive/student/student_box.dart';
import 'package:madrasati/presintation/core/utils/button_service.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/core/utils/progress_bar.dart';
import 'package:madrasati/presintation/phone/features/school_group/school_group.dart';
import 'package:madrasati/presintation/phone/features/student/widgets/st_info.dart';
import 'package:madrasati/presintation/phone/features/user_profile/student_profile.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // User Profile Section
          const ContainerStudentInfo(),

          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: ProgressBar(),
          ),
          // Services Section
          Expanded(
            child: Column(
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
                      ),
                    ),
                    
                    
                         ButtonService(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SchoolGroup(
                                          groupId: getIt<UserBox>().getUser()!.groupId!,
                                          isManager: false,
                                        )));
                          },
                          text: 'School Group',
                          color: Colors.blue,
                        ),
                      
                    
                    ButtonService(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Coming Soon'),
                            content: const Text(
                                'This feature will be available soon'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Ok'))
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        );
                      },
                      text: 'Manaheg',
                      color: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text('Schedule Your Tasks',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: scaleText(20, context),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 40),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0,
                            blurRadius: 7,
                            offset: const Offset(0, 5),
                          ),
                        ]),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text('Create your own \nDaily Lessons schedule',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: scaleText(15, context),
                              fontWeight: FontWeight.bold,
                            )),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Coming Soon'),
                                  content: const Text(
                                      'This feature will be available soon'),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text('Ok'))
                                  ],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              );
                            },
                            icon: const Icon(
                              FontAwesomeIcons.circlePlus,
                              color: Colors.orange,
                              size: 50,
                            )),
                        const Spacer(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
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
          if (index == 0) {
            // Home
          } else if (index == 1) {
            // Profile
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StudentProfile()));
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blueAccent,
                  ),
                  color: Colors.blueAccent,
                ),
                child: Icon(
                  Icons.home_filled,
                  color: Colors.white,
                ),
              ),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
