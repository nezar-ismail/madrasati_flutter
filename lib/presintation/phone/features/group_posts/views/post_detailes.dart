// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/comment_section.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_add_comment.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_body.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_footer.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_header.dart';

// ignore: must_be_immutable
class PostDetails extends StatelessWidget {


  final String schoolName;
  final List<dynamic>? imagePost;
  final String schoolImage;
  final String caption;
  final String postCreatedAt;
  final String likeCount;
  String commentCount;
  final bool isLiked;
  final bool withImage;
  final String postId;


  PostDetails({
    super.key,
    required this.schoolName,
    this.imagePost,
    required this.schoolImage,
    required this.caption,
    required this.postCreatedAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.withImage,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalSpacing = screenHeight * 0.02;

    return BlocProvider(
      create: (context) =>
          PostServicesCubit()..commentCount = commentCount,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true, // Allow resizing when keyboard shows up
        appBar: AppBar(
          title: const Text('Post Details', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: SafeArea(
          // Ensure content stays within safe area of the screen
          child: SingleChildScrollView(
            child: BlocListener<PostServicesCubit, PostServicesState>(
              listener: (context, state) {
                if (state is CommentAdded || state is CommentRemoved) {
                  commentCount = context.read<PostServicesCubit>().commentCount;
                }
              },
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailsHeader(
                    postCreatedAt: postCreatedAt,
                    schoolImage: schoolImage,
                    schoolName: schoolName,
                  ),
                  DetailesBody(
                    caption: caption,
                    withImage: withImage,
                    imagePost: imagePost,
                  ),
                  SizedBox(height: verticalSpacing),
                  BlocBuilder<PostServicesCubit, PostServicesState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DetailesFooter(
                          likeCount: likeCount,
                          commentCount: commentCount,
                          isLiked: isLiked,
                          postId: postId,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: verticalSpacing),
                  CommentSection(postId: postId, withImage: withImage,),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddCommentSection(postId: postId),
        ),
      ),
    );
  }
}
