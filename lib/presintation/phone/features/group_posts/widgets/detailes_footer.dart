import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';

class DetailesFooter extends StatelessWidget {
  const DetailesFooter({
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
  final Duration doubleTapThreshold = const Duration(milliseconds:1500 );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<PostServicesCubit, PostServicesState>(
          builder: (context, state) {
            return _buildLikeButton(context, state);
          },
        ),
        _buildFooterItem(Icons.comment, '$commentCount Comments'),
      ],
    );
  }

  Widget _buildLikeButton(BuildContext context, PostServicesState state) {
    if (state is LikeAdded) {
      return Row(
        children: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.solidThumbsUp,
              color: Colors.blue,
            ),
            onPressed: () {
              final now = DateTime.now();
              if (_lastTapTime == null ||
                  now.difference(_lastTapTime!) > doubleTapThreshold) {
                // This is a single tap
                _lastTapTime = now;
                print("Single tap detected!");
                context.read<PostServicesCubit>().likePostToggle(postId);
              } else {
                print("Double tap detected!");
              }
            },
          ),
          Text(
            '${state.likeCount} Likes',
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      );
    } else if (state is LikeRemoved) {
      return Row(
        children: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.thumbsUp,
              color: Colors.grey.shade800,
            ),
            onPressed: () {
              final now = DateTime.now();
              if (_lastTapTime == null ||
                  now.difference(_lastTapTime!) > doubleTapThreshold) {
                // This is a single tap
                _lastTapTime = now;
                print("Single tap detected!");
                context.read<PostServicesCubit>().likePostToggle(postId);
              } else {
                // This is a double tap
                print("Double tap detected!");
              }
            },
          ),
          Text(
            '${state.likeCount} Likes',
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      );
    }

    return Row(
      children: [
        IconButton(
          icon: Icon(
            isLiked
                ? FontAwesomeIcons.solidThumbsUp
                : FontAwesomeIcons.thumbsUp,
            color: isLiked ? Colors.blue : Colors.grey.shade800,
          ),
          onPressed: () {
            final now = DateTime.now();
            if (_lastTapTime == null ||
                now.difference(_lastTapTime!) > doubleTapThreshold) {
              // This is a single tap
              _lastTapTime = now;
              print("Single tap detected!");
              context.read<PostServicesCubit>().likePostToggle(postId);
            } else {
              // This is a double tap
              print("Double tap detected!");
            }
          },
        ),
        Text(
          '$likeCount Likes',
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildFooterItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }
}
