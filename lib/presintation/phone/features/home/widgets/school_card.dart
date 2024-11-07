import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/home/widgets/school_card_info.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/school_details_page.dart';

class SchoolCard extends StatelessWidget {
  final String schoolName;
  final String schoolType;
  final double rating;
  final String id;
  final String imagePath;

  const SchoolCard({
    super.key,
    required this.schoolName,
    required this.schoolType,
    required this.rating,
    required this.id,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final imageCubit = getIt<NetworkImageCubit>();
    final schoolInfoCubit =getIt<SchoolInfoCubit>();
    final imageFullPath = ApiConstants.baseUrl + imagePath;
    imageCubit.fetchImage(imageFullPath);

    return GestureDetector(
      onTap: () async {
        // Use the existing cubit instance and fetch the info needed
        await schoolInfoCubit.getSchoolInfo(schoolId: id);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => schoolInfoCubit,
              child: SchoolDetailPage(),
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: BlocProvider(
          create: (context) => imageCubit,
          child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
            builder: (context, state) {
              if (state is ImageLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ImageLoaded) {
                return _buildImageContent(state.imageData, context);
              } else if (state is ImageError) {
                return const Center(child: Icon(Icons.error));
              }
              return const SizedBox.shrink(); // Placeholder for initial state
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImageContent(Uint8List imageData, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(imageData),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.18,
        ),
        child: SchoolCardInfo(
          schoolName: schoolName,
          schoolType: schoolType,
          rating: rating,
        ),
      ),
    );
  }
}
