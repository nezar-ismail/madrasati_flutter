import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/post_card/post_body.dart';
import 'package:madrasati/presintation/phone/features/group_posts/views/post_detailes.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/post_card/post_footer.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/post_card/post_header.dart';

class PostCard extends StatelessWidget {
  const PostCard({
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
    final screenWidth = MediaQuery.of(context).size.width;
    final margin = screenWidth * 0.04;
    final padding = screenWidth * 0.02;
    final borderRadius = screenWidth * 0.04;

    if (withImage) {
      final imageCubit = context.read<NetworkImageCubit>();
      final imageFullPath = ApiConstants.baseUrl + schoolImage;
      if (imageCubit.state is! ImageLoaded) {
        imageCubit.fetchImage(imageFullPath);
      }
    }

    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.only(top: padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Post Header
            PostHeader(
              schoolImage: schoolImage,
              postCreatedAt: postCreatedAt,
            ),

            // Post Body
            Expanded(
              child: Column(
                children: [
                  Expanded(child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetails(
                            schoolImage: schoolImage,
                            caption: caption,
                            postCreatedAt: postCreatedAt,
                            likeCount: likeCount,
                            commentCount: commentCount,
                            isLiked: isLiked,
                            withImage: withImage, postId: postId,),
                        ),
                      );
                    },
                    child: PostBody(caption: '${caption}000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'))),
                  withImage
                      ? Expanded(
                          flex: 2,
                          child:
                              _getImage(),
                        )
                      : Container(),
                ],
              ),
            ),

            // Post Footer
            PostFooter(
              likeCount: likeCount,
              commentCount: commentCount,
              isLiked: isLiked,
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<NetworkImageCubit, NetworkImageState> _getImage() {
    return BlocBuilder<NetworkImageCubit, NetworkImageState>(
                          builder: (context, state) {
                            if (state is ImageLoading) {
                              return Container(
                                color: Colors.grey[300],
                                child: const CircularProgressIndicator(),
                              );
                            } else if (state is ImageLoaded) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: MemoryImage(state.imageData),
                                  fit: BoxFit.cover,
                                )),
                              );
                            } else if (state is ImageError) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.error),
                              );
                            }
                            return Container(
                              color: Colors.grey[300],
                            ); // Placeholder for initial state
                          },
                        );
  }
}
