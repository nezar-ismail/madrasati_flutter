import 'dart:developer';
import 'package:flutter/material.dart';

class DetailesCommentSection extends StatelessWidget {
  final String commentCreatedAt;
  final String commentAuthor;
  final String commentText;
  final String commentId;

  const DetailesCommentSection({
    super.key,
    required this.commentId,
    required this.commentCreatedAt,
    required this.commentAuthor,
    required this.commentText,
  });

  @override
  Widget build(BuildContext context) {
    log(commentId);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commentAuthor,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        commentCreatedAt,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Additional options for comment can be added here
                  },
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            Text(
              commentText,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
