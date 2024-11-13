import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/presintation/phone/features/group_posts/add_post/add_post_view.dart';
import 'package:madrasati/presintation/phone/features/school_group/cubit/groupe_post_pagination_cubit.dart';

class SchoolGroup extends StatelessWidget {
  final String groupId;
  final bool isManager;

  const SchoolGroup({super.key, required this.groupId, required this.isManager});

  @override
  Widget build(BuildContext context) {
    log(groupId);
    return BlocProvider(
      create: (context) => GroupePostPaginationCubit()..fetchPosts(groupId),
      child: Scaffold(
        floatingActionButton: isManager ? FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostScreen()));
          }
        ): null,
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
                                0 &&
                            state.hasMore == true && context
                                    .read<GroupePostPaginationCubit>().isFetching == false) {
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