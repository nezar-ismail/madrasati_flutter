import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';

class AddCommentSection extends StatelessWidget {
  const AddCommentSection({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<PostServicesCubit>();
    final TextEditingController _commentController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () async {
              // Handle the comment submission logic
              String comment = _commentController.text;
              if (comment.isNotEmpty) {
                await cubit.addComment(postId, comment);
                _commentController.clear();
                if (cubit.state is !ComentLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Something went wrong, please try again.'),
                  ));
                }
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}
