import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
import 'package:madrasati/data/core/get_it.dart';

class TeacherStaff extends StatelessWidget {
  const TeacherStaff({
    super.key,
    required this.teacherName,
    required this.teacherSubject,
    required this.teacherImage,
    required this.teacherExperience,
    required this.teacherDescription,
  });

  final String teacherName;
  final String teacherSubject;
  final String teacherImage;
  final int teacherExperience;
  final String teacherDescription;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.baseUrl + teacherImage;
    return BlocProvider(
      create: (context) => getIt<NetworkImageCubit>()..fetchImage(imageUrl),
      child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
        builder: (context, state) {
          Widget imageWidget;
          if (state is ImageLoading) {
            imageWidget = const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey, // Placeholder color while loading
            );
          } else if (state is ImageLoaded) {
            imageWidget = CircleAvatar(
              radius: 25,
              backgroundImage: MemoryImage(state.imageData),
            );
          } else if (state is ImageError) {
            imageWidget = const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.red, // Color to indicate error
              child: Icon(Icons.error, color: Colors.white),
            );
          } else {
            imageWidget = const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey, // Fallback if state is undefined
            );
          }
          return  Column(
                  children: [
                    imageWidget,
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text(
                      teacherName,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

//All Teacher
