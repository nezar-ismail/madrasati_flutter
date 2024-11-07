import 'dart:developer';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/core/utils/coustum_loading.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/widgets/all_teacher.dart';
import 'package:madrasati/presintation/phone/features/school_info/widgets/school_info.dart';
import 'package:madrasati/presintation/phone/features/school_info/widgets/teacher_staff.dart';

class SchoolDetailPage extends StatelessWidget {
  const SchoolDetailPage({super.key});

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
              title: Text(
                state.schoolProfilePage.schoolName,
                style: const TextStyle(fontFamily: 'Roboto'),
              ),
              backgroundColor: Colors.orange,
            ),
            body: SingleChildScrollView(
              padding:
                  MediaQuery.of(context).viewInsets + const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSchoolName(context, state.schoolProfilePage.schoolName),

                  // Main Image with Tap-to-Show Slider
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: BlocProvider(
                      create: (context) => getIt<NetworkImageCubit>()
                        ..fetchImage(ApiConstants.baseUrl +
                            state.schoolProfilePage.schoolCoverImage),
                      child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
                        builder: (context, imageState) {
                          if (imageState is ImageLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (imageState is ImageLoaded) {
                            return GestureDetector(
                              onTap: () => _showImageSlider(context,
                                  state.schoolProfilePage.schoolImages, 0),
                              child: _buildImageContainer(
                                  imageState.imageData, context),
                            );
                          } else if (imageState is ImageError) {
                            return const Center(child: Icon(Icons.error));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle(context, 'Teacher Staff'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AllTeacherStaff(teacherList: state.schoolProfilePage.teachers,)));
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: scaleText(12, context),
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: state.schoolProfilePage.teachers.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          log(state.schoolProfilePage.teachers.length.toString());
                          final teacher = state.schoolProfilePage.teachers[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: TeacherStaff(
                              teacherExperience: teacher.teacherExperience,
                              teacherDescription: teacher.teacherDescription,
                              teacherName: teacher.teacherName,
                              teacherSubject: teacher.teacherSubject, teacherImage: teacher.teacherImage,
                              
                            ),
                          );
                        
                      }),
                    )
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
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: scaleText(20, context),
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  void _showImageSlider(
      BuildContext context, List<dynamic> imageUrls, int initialIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          child: CarouselSlider.builder(
            itemCount: imageUrls.length,
            options: CarouselOptions(
              initialPage: initialIndex,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
            ),
            itemBuilder: (context, index, _) {
              final imageUrl = ApiConstants.baseUrl + imageUrls[index];
              return BlocProvider(
                create: (context) =>
                    getIt<NetworkImageCubit>()..fetchImage(imageUrl),
                child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ImageLoaded) {
                      return Image.memory(
                        state.imageData,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    } else if (state is ImageError) {
                      return Center(
                        child: Icon(Icons.error, color: Colors.red, size: 60),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
