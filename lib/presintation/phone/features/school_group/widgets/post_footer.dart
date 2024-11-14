import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';

class PostFooter extends StatelessWidget {
  const PostFooter({
    super.key,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.postId,
  });

  final String likeCount;
  final String commentCount;
  final bool isLiked;
  final String postId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.06; // Dynamic icon size based on screen width
    final fontSize = screenWidth * 0.04; // Dynamic font size based on screen width
    final padding = screenWidth * 0.02; // Dynamic padding based on screen width

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: padding),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
              ),
              color: Colors.grey.shade300,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: iconSize,
                  icon: Icon(
                    FontAwesomeIcons.comment,
                    color: Colors.grey.shade800,
                  ),
                  onPressed: () {},
                ),
                Text(
                  commentCount,
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: padding),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
              ),
              color: Colors.grey.shade300,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: BlocProvider(
              create: (context) => PostServicesCubit(),
              child: BlocBuilder<PostServicesCubit, PostServicesState>(
                builder: (context, state) {
                  bool liked = isLiked;
                  String count = likeCount;
            
                  if (state is LikeAdded && !liked) {
                    liked = true;
                    count = '${int.parse(count) + 1}';
                  } else if (state is LikeRemoved && liked) {
                    liked = false;
                    count = '${int.parse(count) - 1}';
                  }
            
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: iconSize,
                        icon: Icon(
                          liked
                              ? FontAwesomeIcons.solidThumbsUp
                              : FontAwesomeIcons.thumbsUp,
                          color: liked ? Colors.blue : Colors.grey.shade800,
                        ),
                        onPressed: () {
                          liked
                              ? context.read<PostServicesCubit>().unlikePost(postId)
                              : context.read<PostServicesCubit>().likePost(postId);
                        },
                      ),
                      Text(
                        '$count Likes',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
