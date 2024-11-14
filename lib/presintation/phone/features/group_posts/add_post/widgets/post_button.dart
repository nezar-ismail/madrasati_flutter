import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/hive/student/student_box.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/cubit/pick_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';

class PostButton extends StatelessWidget {
  final TextEditingController captionController;

  const PostButton({required this.captionController, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostServicesCubit(),
      child: BlocListener<PostServicesCubit, PostServicesState>(
        listener: (context, state) {
          if (state is PostCreated) {
            Navigator.popUntil(context, 
              (route) => route.isFirst,
            );
            var overlay = Overlay.of(context);
            final message = 'Post created successfully';
            final icon = Icons.done;
            final color = Colors.green;
            customSnackbar(overlay, message, icon, color);
          }
        },
        child: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                final pickImageCubit = context.read<PickImageCubit>().state;
                if (pickImageCubit is PickImageSuccess &&
                    pickImageCubit.selectedFiles.isNotEmpty) {
                  final groupId = getIt<UserBox>().getGroupId();
                  if (groupId != null) {
                    context.read<PostServicesCubit>().createPost(
                          groupId,
                          pickImageCubit.pathes,
                          captionController.text,
                        );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text(
                'Post',
                style: TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
