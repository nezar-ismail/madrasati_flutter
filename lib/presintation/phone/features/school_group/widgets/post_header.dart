import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.schoolImage,
    required this.postCreatedAt,
  });

  final String schoolImage;
  final String postCreatedAt;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.1; // Responsive avatar size
    final padding = screenWidth * 0.02;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<NetworkImageCubit, NetworkImageState>(
            builder: (context, state) {
              if (state is ImageLoading) {
                return CircleAvatar(
                  radius: avatarRadius,
                  child: const CircularProgressIndicator(),
                );
              } else if (state is ImageLoaded) {
                return CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: MemoryImage(state.imageData),
                );
              } else if (state is ImageError) {
                return CircleAvatar(
                  radius: avatarRadius,
                  child: LoadingIndicator(indicatorType: Indicator.ballRotateChase, colors: const [Colors.black, Colors.red, Colors.orange, Colors.yellow, Colors.blue, Colors.green], pathBackgroundColor: Colors.white,),
                );
              }
              return CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.grey[300],
              ); // Placeholder for initial state
            },
          ),
          Text(
            postCreatedAt
                .substring(0, 16)
                .replaceAll('-', '/')
                .replaceAll('T', ' - '),
            style: TextStyle(
              fontSize: scaleText(16, context), // Dynamic text scaling
              fontFamily: 'Roboto',
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
