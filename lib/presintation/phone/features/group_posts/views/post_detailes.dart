import 'package:flutter/material.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/comment_section.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_add_comment.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_body.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_footer.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_header.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({
    super.key,
    required this.schoolImage,
    required this.caption,
    required this.postCreatedAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.withImage,
    required this.postId,
    this.imagePost,
  });

  final List<dynamic>? imagePost;
  final String schoolImage;
  final String caption;
  final String postCreatedAt;
  final String likeCount;
  final String commentCount;
  final bool isLiked;
  final bool withImage;
  final String postId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final padding = screenWidth * 0.04;
    final verticalSpacing = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsHeader(
              postCreatedAt: postCreatedAt,
              schoolImage: schoolImage,
              schoolName: 'School Name',
            ),
            SizedBox(height: verticalSpacing),
            DetailesBody(
              caption: caption,
              withImage: withImage,
              imagePost: imagePost,
            ),
            SizedBox(height: verticalSpacing),
            DetailesFooter(
              likeCount: likeCount,
              commentCount: commentCount,
              isLiked: isLiked,
              postId: postId,
            ),
            SizedBox(height: verticalSpacing),
            CommentSection(postId: postId),
            SizedBox(height: verticalSpacing),
            const AddCommentSection(),
          ],
        ),
      ),
    );
  }
}
