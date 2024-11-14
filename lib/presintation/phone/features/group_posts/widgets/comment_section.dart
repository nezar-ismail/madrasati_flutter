import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_comment_section.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({
    super.key,
    required this.postId,
    required this.withImage,
  });

  final String postId;
  final bool withImage;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostServicesCubit>()..fetchComments(postId);
    return BlocConsumer<PostServicesCubit, PostServicesState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: const Text(
                  'Comments',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8.0),
              if (state is PostServicesLoading)
                const Center(child: CircularProgressIndicator()),
              if (state is CommentEmpty)
                const Center(child: Text('No comments yet')),
              if (state is ComentLoaded)
                SizedBox(
                  height: withImage
                      ? MediaQuery.of(context).size.height * 0.26
                      : MediaQuery.of(context).size.height * 0.5,
                  child: Expanded(
                    child: Column(
                      children: [
                        // Load More Button
                        if (state.hasMore)
                          TextButton(
                            onPressed: () async {
                              if (!state.hasMore || cubit.isFetching) return;
                              await cubit.fetchComments(postId);
                            },
                            child: const Text('View More Comments'),
                          ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.comments.length,
                            itemBuilder: (context, index) {
                              final comment = state.comments[index];
                              return DetailesCommentSection(
                                cubit: cubit,
                                authorId: comment.authorId,
                                commentCreatedAt: comment.createdAt,
                                commentText: comment.comment,
                                commentAuthor: comment.author,
                                commentId: comment.commentId,
                                postId: postId,
                                isManager:
                                    getIt<UserProfileCubit>().state?.lastName ==
                                            "Manager"
                                        ? true
                                        : false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (state is PostServicesError)
                Center(child: Text('Error: ${state.message}')),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is PostServicesError) {
          final overlayState = Overlay.of(context);
          customSnackbar(
              overlayState,
              "${state.message} Please check your internet connection and try again",
              Icons.error,
              Colors.red);
        } else if (state is PostServicesLoading) {
          final overlayState = Overlay.of(context);
          customSnackbar(overlayState, "Loading comments", Icons.done, Colors.blue);
        }
      },
    );
  }
}
