import 'package:flutter/material.dart';
import 'package:madrasati/presintation/features/school_info/school_info.dart';
import 'package:madrasati/presintation/features/school_info/teacher_staff.dart';

class SchoolDetailPage extends StatelessWidget {
  const SchoolDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Name'),
        backgroundColor: Colors.orange,
      ),
      body: Expanded(
        child: SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets + EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // School Name
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'School Name',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),

              // Image Slider
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      image: const DecorationImage(
                        image: AssetImage('asset/static/image/school.png'),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade800.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Text(
                        'See All Pictures',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // School Bio
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  'School Bio',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'This is a short paragraph describing the school bio. It can be expanded to contain more information about the school\'s history, mission, etc.',
                ),
              ),

              // School Info
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  'School Info',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: SchoolInfo(),
              ),

              // Teacher Staff
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Teacher Staff',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TeacherStaff(),
              ),

              // Feedback Section (Placeholder)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Feedback',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
