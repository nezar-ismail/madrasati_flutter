
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/cubit/pick_image_cubit.dart';

class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onPressed: () => context.read<PickImageCubit>().pickImages(),
        child: const Icon(Icons.add_a_photo_outlined, color: Colors.white,),
      ),
    );
  }
}