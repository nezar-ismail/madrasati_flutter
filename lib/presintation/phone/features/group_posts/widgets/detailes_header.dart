import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({
    super.key,
    required this.postCreatedAt,
    required this.schoolImage, required this.schoolName,
  });

  final String postCreatedAt;
  final String schoolImage;
  final String schoolName;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.12; // Adjust the image size relative to screen width
    final padding = screenWidth * 0.04; // Adjust padding based on screen width
    final borderRadius = screenWidth * 0.03;

    final imageUrl = ApiConstants.baseUrl + schoolImage;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.blue[50],
      ),
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          ClipOval(
            child: BlocProvider(
              create: (context) => getIt<NetworkImageCubit>()..fetchImage(imageUrl),
              child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
                builder: (context, state) {
                  if (state is ImageLoading) {
                    return SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (state is ImageLoaded) {
                    return Image.memory(
                      state.imageData,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    );
                  } else if (state is ImageError) {
                    return Icon(
                      Icons.error,
                      color: Colors.red,
                      size: imageSize,
                    );
                  }
                  return SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: const Icon(
                      Icons.image,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: padding * 0.6), // Adjust horizontal spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schoolName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045, // Responsive font size
                  ),
                ),
                Text(
                  'Posted in ${postCreatedAt.substring(0, 16).replaceAll('-', '/').replaceAll('T', ' - At ')}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.035, // Responsive font size for subtitle
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
