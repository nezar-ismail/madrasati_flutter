import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/cubit/pick_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/widgets/add_photos_button.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/widgets/caption_input_feild.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/widgets/header_titel.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/widgets/image_preview.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/widgets/post_button.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  final TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PickImageCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const HeaderTitle(),
              const SizedBox(height: 10),
              CaptionInputField(controller: captionController),
              const SizedBox(height: 10),
              const AddPhotoButton(),
              const SizedBox(height: 10),
              const ImagePreview(),
              const SizedBox(height: 10),
              PostButton(captionController: captionController),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      title: const Text('School Name'),
      centerTitle: true,
    );
  }
}


