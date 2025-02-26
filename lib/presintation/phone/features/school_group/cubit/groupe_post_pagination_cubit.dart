import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/models/group_models/group_post_page.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/group_post_service.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_group/widgets/post_card.dart';

part 'groupe_post_pagination_state.dart';

class GroupePostPaginationCubit extends Cubit<GroupePostPaginationState> {
  GroupePostPaginationCubit()
      : super(GroupePostPaginationInitial());
  final GroupPostService _groupPostService = getIt<GroupPostService>();
  int currentPage = 0;
  bool last = false;
  bool isFetching = false;
  List<Widget> posts = [];
  ScrollController scrollController = ScrollController();

  Future<Color> fetchHeaderColor() async {
      var color = await SecureStorageApi.instance.getRole();
      if (color == 'school_manager') {
        return Colors.green;
      } else {
        return Colors.blue;
      }    
  }

  /// Fetches a page of posts from the server and updates the state with the fetched
  /// posts. If there are no more pages to fetch, [last] is set to false.
  ///
  /// If the fetching is successfull, the state is updated with the fetched posts
  /// and [last] flag. If the fetching fails, the state is updated with the
  /// error message.
  ///
  /// This method is idempotent, meaning it can be safely called multiple times,
  /// and it will only fetch new posts if there are more posts to fetch.
  ///
  /// [groupId] is the id of the school group to fetch posts from.
  Future<void> fetchPosts(String groupId) async {
    log('last: $last');
    if (last == true || isFetching == true)return; // Stop fetching if no more pages or already fetching
    isFetching = true; // Set fetching flag to true to prevent multiple calls
    emit(PostLoading());
    try {
      final response = await _groupPostService.getAllPosts(
          groupId: groupId,
          token: await SecureStorageApi.instance.getAccessToken() ?? "",
          page: currentPage,
          size: 10);
      if (response is PostResponse) {
        var headerColor = await fetchHeaderColor();
        currentPage++;
        last = response.last; // Update hasMore based on response
        
        log('last response: ${response.last}');

        // Convert the fetched data to PostCard widgets
        posts.addAll(response.content
            .map(
              (post) => BlocProvider(
                create: (context) => NetworkImageCubit()
                  ..fetchImage(ApiConstants.baseUrl + post.schoolImagePath),
                child: PostCard(
                  schoolImage: post.schoolImagePath,
                  caption: post.caption?? '',
                  postCreatedAt: post.postCreatedAt,
                  likeCount: post.numberOfLike.toString(),
                  commentCount: post.numberOfComment.toString(),
                  isLiked: post.isLiked,
                  withImage: post.withImage,
                  postId: post.postId,
                  imagePost: post.imagePost, schoolName: post.schoolName, headerColor: headerColor,
                ),
              ),
            )
            .toList());
            isFetching = false;
        emit(PostLoaded(posts: posts, last: last));
      }else if (response is EmptyResponse){
        last = false;
        emit(PostEmpty());
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
