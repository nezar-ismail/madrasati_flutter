
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PostServicesCubit>()..fetchComments(postId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Comments',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          BlocBuilder<PostServicesCubit, PostServicesState>(
            builder: (context, state) {
              if (state is PostServicesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ComentLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  controller:
                      context.read<PostServicesCubit>().scrollController
                        ..addListener(() {
                          if (context
                                  .read<PostServicesCubit>()
                                  .scrollController
                                  .position
                                  .atEdge &&
                              context
                                      .read<PostServicesCubit>()
                                      .scrollController
                                      .position
                                      .pixels !=
                                  0 &&
                              state.hasMore == true &&
                              context
                                      .read<PostServicesCubit>()
                                      .isFetching ==
                                  false) {
                            context
                                .read<PostServicesCubit>()
                                .fetchComments(postId);
                          }
                        }),
                  itemCount:
                      state.comments.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.comments.length &&
                        state.hasMore) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
    
                    return state.comments[index];
                  },
                );
              } else if (state is PostServicesError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

