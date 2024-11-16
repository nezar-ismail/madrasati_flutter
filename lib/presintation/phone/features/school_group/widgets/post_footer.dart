import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';

class PostFooter extends StatelessWidget {
  PostFooter({
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
  static DateTime? _lastTapTime; // Static to maintain state between builds
  final Duration doubleTapThreshold = const Duration(milliseconds: 1500);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize =
        screenWidth * 0.06; // Dynamic icon size based on screen width
    final fontSize =
        screenWidth * 0.04; // Dynamic font size based on screen width
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
                  onPressed: (null),
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
            child: BlocBuilder<PostServicesCubit, PostServicesState>(
              builder: (context, state) {
                if (state is LikeAdded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: iconSize,
                        icon: Icon(FontAwesomeIcons.solidThumbsUp,
                            color: Colors.blue, size: iconSize),
                        onPressed: () {
                          final now = DateTime.now();
                          if (_lastTapTime == null ||
                              now.difference(_lastTapTime!) >
                                  doubleTapThreshold) {
                            // This is a single tap
                            _lastTapTime = now;
                            print("Single tap detected!");
                            context
                                .read<PostServicesCubit>()
                                .likePostToggle(postId);
                          } else {
                            // This is a double tap
                            print("Double tap detected!");
                          }
                        },
                      ),
                      Text(
                        '${state.likeCount} Likes',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ],
                  );
                } else if (state is LikeRemoved) {
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: iconSize,
                        icon: Icon(
                          FontAwesomeIcons.thumbsUp,
                          color: Colors.grey.shade800,
                        ),
                        onPressed: () {
                          final now = DateTime.now();
                          if (_lastTapTime == null ||
                              now.difference(_lastTapTime!) >
                                  doubleTapThreshold) {
                            // This is a single tap
                            _lastTapTime = now;
                            print("Single tap detected!");
                            context
                                .read<PostServicesCubit>()
                                .likePostToggle(postId);
                          } else {
                            // This is a double tap
                            print("Double tap detected!");
                          }
                        },
                      ),
                      Text(
                        '${state.likeCount} Likes',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ],
                  );
                }
            
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: iconSize,
                      icon: Icon(
                        isLiked
                            ? FontAwesomeIcons.solidThumbsUp
                            : FontAwesomeIcons.thumbsUp,
                        color: isLiked ? Colors.blue : Colors.grey.shade800,
                      ),
                      onPressed: () async {
                        final now = DateTime.now();
                        if (_lastTapTime == null ||
                            now.difference(_lastTapTime!) >
                                doubleTapThreshold) {
                          // This is a single tap
                          _lastTapTime = now;
                          print("Single tap detected!");
                          await context
                              .read<PostServicesCubit>()
                              .likePostToggle(postId);
                        } else {
                          print("Double tap detected!");
                        }
                      },
                    ),
                    Text(
                      '$likeCount Likes',
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
