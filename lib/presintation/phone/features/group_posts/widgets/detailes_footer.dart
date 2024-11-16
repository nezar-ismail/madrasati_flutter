import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';

class DetailesFooter extends StatefulWidget {
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

  @override
  _DetailesFooterState createState() => _DetailesFooterState();
}

class _DetailesFooterState extends State<DetailesFooter> {
  bool isCooldown = false; // Track cooldown state

  void _handleLikePressed(BuildContext context, bool liked) {
    if (isCooldown) return;

    setState(() {
      isCooldown = true;
    });

    liked
        ? context.read<PostServicesCubit>().unlikePost(widget.postId)
        : context.read<PostServicesCubit>().likePost(widget.postId);

    // Start cooldown timer
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isCooldown = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocProvider(
          create: (context) => PostServicesCubit(),
          child: BlocBuilder<PostServicesCubit, PostServicesState>(
            builder: (context, state) {
              return state is PostServicesLoading
                  ? const CircularProgressIndicator()
                  : _buildLikeButton(context, state);
            },
          ),
        ),
        _buildFooterItem(Icons.comment, '${widget.commentCount} Comments'),
      ],
    );
  }

  Widget _buildLikeButton(BuildContext context, PostServicesState state) {
    bool liked = widget.isLiked;
    String count = widget.likeCount;

    if (state is LikeAdded && !liked) {
      liked = true;
      count = '${int.parse(count) + 1}';
    } else if (state is LikeRemoved && liked) {
      liked = false;
      count = '${int.parse(count) - 1}';
    }

    return Row(
      children: [
        IconButton(
          icon: Icon(
            liked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
            color: _getLikeColor(liked),
          ),
          onPressed: isCooldown
              ? null // Disable button if cooldown is active
              : () => _handleLikePressed(context, liked),
        ),
        Text(
          '$count Likes',
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  Color _getLikeColor(bool liked) => liked ? Colors.blue : Colors.grey.shade800;

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
