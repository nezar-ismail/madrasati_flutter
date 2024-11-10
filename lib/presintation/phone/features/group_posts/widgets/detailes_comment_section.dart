import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';

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
    log('commentAuthor = $commentAuthor');
    log('userId = ${getIt<UserProfileCubit>().state!.studentId}');
    log(commentId);

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          commentAuthor,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AutoSizeText(
                          commentCreatedAt
                              .replaceAll('-', '/')
                              .replaceAll('T', ' - ')
                              .substring(0, 18),
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      commentAuthor ==
                              getIt<UserProfileCubit>().state?.studentId
                          ? IconButton(
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
                                              await context
                                                  .read<PostServicesCubit>()
                                                  .deleteComment(
                                                      commentId, commentId);
                                              if (context
                                                  .read<PostServicesCubit>()
                                                  .state is CommentRemoved) {
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.delete),
                            )
                          : SizedBox.shrink()
                    ],
                  ),
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
