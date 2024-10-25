import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/core/utils/coustum_loading.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
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
          // Get the image path and load it via NetworkImageCubit
          final imageFullPath = ApiConstants.baseUrl + state.schoolProfilePage.schoolCoverImage;
          final imageCubit = context.read<NetworkImageCubit>();

          // Trigger image fetching if not already loaded
          if (imageCubit.state is! ImageLoaded) {
            imageCubit.fetchImage(imageFullPath, );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.schoolProfilePage.schoolName,
                style: const TextStyle(fontFamily: 'Roboto'),
              ),
              backgroundColor: Colors.orange,
            ),
            body: SingleChildScrollView(
              padding: MediaQuery.of(context).viewInsets + const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSchoolName(context, state.schoolProfilePage.schoolName),
                  
                  // Image slider with cubit state handling
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
                      builder: (context, imageState) {
                        if (imageState is ImageLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (imageState is ImageLoaded) {
                          return _buildImageContainer(imageState.imageData, context);
                        } else if (imageState is ImageError) {
                          return const Center(child: Icon(Icons.error));
                        }
                        return const SizedBox.shrink(); // Placeholder for initial state
                      },
                    ),
                  ),

                  // School Bio Section
                  _buildSectionTitle(context, 'School Bio'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      state.schoolProfilePage.schoolDescription,
                      style: const TextStyle(fontFamily: 'Roboto'),
                    ),
                  ),

                  // School Info Section
                  _buildSectionTitle(context, 'School Info'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: schoolInfo(context, state),
                  ),

                  // Teacher Staff Section
                  _buildSectionTitle(context, 'Teacher Staff'),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: TeacherStaff(),
                  ),

                  // Feedback Section Placeholder
                  _buildSectionTitle(context, 'Feedback'),
                ],
              ),
            ),
          );
        }

        if (state is SchoolInfoError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Something went wrong'));
      },
    );
  }

  Widget _buildSchoolName(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        name,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: scaleText(20, context),
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildImageContainer(Uint8List imageData, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: MemoryImage(imageData),
          fit: BoxFit.cover,
        ),
      ),
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
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: scaleText(20, context),
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      ),
    );
  }
}
