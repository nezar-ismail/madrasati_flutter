
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/cubit/pick_image_cubit.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickImageCubit, PickImageState>(
      builder: (context, state) {
        if (state is PickImageLoading) {
          return const CircularProgressIndicator();
        } else if (state is PickImageFailure) {
          return Text(
            state.message,
            style: const TextStyle(color: Colors.red),
          );
        } else if (state is PickImageSuccess && state.selectedFiles.isNotEmpty) {
          return Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: state.selectedFiles.map((file) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  file!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
