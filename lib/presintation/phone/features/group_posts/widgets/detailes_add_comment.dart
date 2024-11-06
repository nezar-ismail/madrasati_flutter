

import 'package:flutter/material.dart';

class AddCommentSection extends StatelessWidget {
  const AddCommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();
    return Row(
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
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        ElevatedButton(
          onPressed: () {
            // Handle the comment submission logic
            String comment = _commentController.text;
            if (comment.isNotEmpty) {
              // Call a function to submit the comment
              // submitComment(comment);
              _commentController.clear();
            }
          },
          child: const Text('Post'),
        ),
      ],
    );
  }
}
