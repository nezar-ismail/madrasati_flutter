import 'package:animations/animations.dart';
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
    return BlocProvider(
      create: (context) => GroupePostPaginationCubit()..fetchPosts(groupId),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: isManager ? OpenContainer(
                transitionType: ContainerTransitionType.fadeThrough,
                closedShape: const CircleBorder(),
                closedColor: Theme.of(context).primaryColor,
                closedBuilder: (context, action) => FloatingActionButton(
                  onPressed: action,
                  child: const Icon(Icons.add), // Trigger the OpenContainer animation
                ),
                openBuilder: (context, action) => AddPostScreen(),
                transitionDuration: const Duration(seconds: 1),
              )
            : null,
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: isManager ? Colors.orange : Colors.blue,
          title: const Text(
            'School Group',
            style: TextStyle(fontFamily: 'Roboto', color: Colors.white),
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
            } if (state is PostEmpty) {
              return Center(child: Text('No posts yet'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}