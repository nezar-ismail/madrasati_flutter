import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/services/group_post_service.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/school_group/cubit/groupe_post_pagination_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SchoolGroup extends StatelessWidget {
  final String groupId;

  const SchoolGroup({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    log(groupId);
    return BlocProvider(
      create: (context) => getIt<GroupePostPaginationCubit>()..fetchPosts(groupId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'School Group',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
        ),
        body: BlocBuilder<GroupePostPaginationCubit, GroupePostPaginationState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } if (state is PostLoaded) {
              return ListView.builder(
                controller:
                    context.read<GroupePostPaginationCubit>().scrollController
                      ..addListener(() {
                        // Trigger fetch when reaching the end of the list
                        if (context
                                .read<GroupePostPaginationCubit>()
                                .scrollController
                                .position
                                .atEdge &&
                            context
                                    .read<GroupePostPaginationCubit>()
                                    .scrollController
                                    .position
                                    .pixels !=
                                0) {
                          context.read<GroupePostPaginationCubit>().fetchPosts(groupId);
                        }
                      }),
                itemCount: state.posts.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.posts.length && state.hasMore) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return state.posts[index];
                },
              );
            } if (state is PostError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.schoolImage,
    required this.caption,
    required this.postCreatedAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.postId,
  });

  final String schoolImage;
  final String caption;
  final String postCreatedAt;
  final String likeCount;
  final String commentCount;
  final bool isLiked;
  final String postId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PostHeader(schoolImage: schoolImage, postCreatedAt: postCreatedAt),
          PostBody(caption: caption),
          PostFooter(
            likeCount: likeCount,
            commentCount: commentCount,
            isLiked: isLiked,
          ),
        ],
      ),
    );
  }
}

class PostFooter extends StatelessWidget {
  const PostFooter({
    super.key,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
  });

  final String likeCount;
  final String commentCount;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            icon: const Icon(FontAwesomeIcons.comment),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(
              isLiked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
            ),
            onPressed: () {
              // Handle like toggle functionality here
            },
          ),
        ),
      ],
    );
  }
}

class PostBody extends StatelessWidget {
  const PostBody({
    super.key,
    required this.caption,
  });

  final String caption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        caption,
        style: const TextStyle(fontFamily: 'Roboto'),
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.schoolImage,
    required this.postCreatedAt,
  });

  final String schoolImage;
  final String postCreatedAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(schoolImage),
        ),
        Text(
          'User Name',
          style: TextStyle(
            fontSize: scaleText(24, context),
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        Text(
          postCreatedAt,
          style: TextStyle(fontSize: scaleText(16, context), fontFamily: 'Roboto'),
        ),
      ],
    );
  }
}
