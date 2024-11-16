import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/hive/student/student_box.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';

class DetailesCommentSection extends StatelessWidget {
  final String commentCreatedAt;
  final String commentAuthor;
  final String commentText;
  final String commentId;
  final String authorId;
  final String postId;
  final PostServicesCubit cubit;
  final bool isManager;

  const DetailesCommentSection({
    super.key,
    required this.commentId,
    required this.commentCreatedAt,
    required this.commentAuthor,
    required this.commentText,
    required this.authorId,
    required this.cubit,
    required this.postId,
    required this.isManager,
  });

  @override
Widget build(BuildContext context) {
  // Retrieve the screen width and calculate responsive sizes
  final screenWidth = MediaQuery.of(context).size.width;
  final isLargeScreen = screenWidth > 600;

  return Card(
    color: Colors.white,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: isLargeScreen ? 32.0 : 16.0,
    ),
    child: Padding(
      padding: EdgeInsets.all(isLargeScreen ? 24.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      commentAuthor,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AutoSizeText(
                      commentCreatedAt
                          .replaceAll('-', '/')
                          .replaceAll('T', ' - ')
                          .substring(0, 18),
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (authorId == getIt<UserBox>().getUser()!.studentId || isManager)
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Comment'),
                          content: const Text(
                              'Are you sure you want to delete this comment?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await cubit.deleteComment(postId, commentId);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
            ],
          ),
          const Divider(height: 20, thickness: 1),
          Text(
            commentText,
            style: TextStyle(
              fontSize: isLargeScreen ? 16 : 14,
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
