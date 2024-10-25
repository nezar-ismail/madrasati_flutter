import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/core/utils/coustum_loading.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/widgets/school_info.dart';
import 'package:madrasati/presintation/phone/features/school_info/widgets/teacher_staff.dart';

class SchoolDetailPage extends StatelessWidget {

  const SchoolDetailPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolInfoCubit, SchoolInfoState>(
      builder: (context, state) {
        if (state is SchoolInfoLoading) {
          return const CustomLoading();
        }
        if (state is SchoolInfoLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.schoolProfilePage.schoolName,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                  )),
              backgroundColor: Colors.orange,
            ),
            body: SingleChildScrollView(
              padding: MediaQuery.of(context).viewInsets +
                  const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // School Name
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      state.schoolProfilePage.schoolName,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: scaleText(20, context),
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
                          image: DecorationImage(
                            image: AssetImage('asset/static/image/school.png'),
                            fit: BoxFit.contain,
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
                              fontFamily: 'Roboto',
                              fontSize: scaleText(20, context),
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
                        fontFamily: 'Roboto',
                        fontSize: scaleText(20, context),
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
            
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      state.schoolProfilePage.schoolDescription,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
            
                  // School Info
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      'School Info',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: scaleText(20, context),
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
            
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: schoolInfo(context, state),
                  ),
            
                  // Teacher Staff
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Teacher Staff',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: scaleText(20, context),
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
                        fontFamily: 'Roboto',
                        fontSize: scaleText(20, context),
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    
        if (state is SchoolInfoError) {
          return Text(state.message);
        }
        return const Text('Something went wrong');
      },
    );
  }


}
