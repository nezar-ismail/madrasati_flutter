import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/models/school_models/schoolPage/school_teacher.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';

class AllTeacherStaff extends StatelessWidget {
  const AllTeacherStaff({
    super.key,
    required this.teacherList,
  });

  final List<Teacher> teacherList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Teachers Staff',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: teacherList.length,
        itemBuilder: (BuildContext context, int index) {
          final imageUrl =
              ApiConstants.baseUrl + teacherList[index].teacherImage;
          return BlocProvider(
            create: (context) =>
                NetworkImageCubit()..fetchImage(imageUrl),
            child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
              builder: (context, state) {
                Widget imageWidget;
                if (state is ImageLoading) {
                  imageWidget = const CircleAvatar(
                    radius: 25,
                    backgroundColor:
                        Colors.grey, // Placeholder color while loading
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
                    backgroundColor:
                        Colors.grey, // Fallback if state is undefined
                  );
                }
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        imageWidget,
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  teacherList[index].teacherName,
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  ' - ${teacherList[index].teacherSubject}',
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Text(
                              teacherList[index].teacherDescription,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                                color: Colors.black,
                              ),
                            ),
                              Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Text(
                                  '${teacherList[index].teacherExperience} Years Exp',
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
