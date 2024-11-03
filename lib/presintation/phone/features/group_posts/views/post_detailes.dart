import 'package:flutter/material.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/post_detailes/detailes_add_comment.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/post_detailes/detailes_body.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/post_detailes/detailes_comment_section.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/post_detailes/detailes_footer.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/post_detailes/detailes_header.dart';

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
  });

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsHeader(
              postCreatedAt: postCreatedAt,
            ),
            const SizedBox(height: 12.0),
            DetailesBody(caption: caption, withImage: withImage),
            const SizedBox(height: 12.0),
            DetailesFooter(
              likeCount: likeCount,
              commentCount: commentCount, 
              isLiked: isLiked,
            ),
            const SizedBox(height: 12.0),
            DetailesCommentSection(),
            const SizedBox(height: 12.0),
            const AddCommentSection(),
          ],
        ),
      ),
    );
  }
}

