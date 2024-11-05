import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/core/get_it.dart';
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
    required this.imagePost,
  });

  final String schoolImage;
  final String caption;
  final String postCreatedAt;
  final String likeCount;
  final String commentCount;
  final bool isLiked;
  final bool withImage;
  final String postId;
  final List<dynamic>? imagePost;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final margin = screenWidth * 0.04;
    final padding = screenWidth * 0.02;
    final borderRadius = screenWidth * 0.04;

    final postMainImageCubit = getIt<NetworkImageCubit>();
    final imageFullPath = ApiConstants.baseUrl + schoolImage;
    postMainImageCubit.fetchImage(imageFullPath);

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
      child: GestureDetector(
        onTap: () {
          log('Post ID: $postId');
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
                withImage: withImage,
                postId: postId,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Post Header
            PostHeader(
              schoolImage: schoolImage,
              postCreatedAt: postCreatedAt,
            ),

            // Post Body
            PostBody(
              caption: caption,
            ),

            // Optional Post Image
            if (withImage && imagePost != null && imagePost!.isNotEmpty)
              SizedBox(
                height: 200, // Adjust height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagePost!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _showImageSlider(context, imagePost!, index),
                      child: BlocProvider(
                        create: (context) => getIt<NetworkImageCubit>()
                          ..fetchImage(
                              ApiConstants.baseUrl + imagePost![index]),
                        child:
                            BlocBuilder<NetworkImageCubit, NetworkImageState>(
                          builder: (context, state) {
                            if (state is ImageLoading) {
                              return Container(
                                width: 200,
                                color: const Color.fromARGB(255, 60, 60, 60),
                                child: const CircularProgressIndicator(),
                              );
                            } else if (state is ImageLoaded) {
                              return Container(
                                width: screenWidth * 0.8,
                                margin: const EdgeInsets.only(right: 8.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(state.imageData),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else if (state is ImageError) {
                              return Container(
                                width: 200,
                                color: Colors.grey[300],
                                child: const Icon(Icons.error),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            // Post Footer
            PostFooter(
              likeCount: likeCount,
              commentCount: commentCount,
              isLiked: isLiked, postId: postId,
            ),
          ],
        ),
      ),
    );
  }
}

void _showImageSlider(
    BuildContext context, List<dynamic> imageUrls, int initialIndex) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.black,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CarouselSlider.builder(
            itemCount: imageUrls.length,
            options: CarouselOptions(
              initialPage: initialIndex,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
            ),
            itemBuilder: (context, index, _) {
              final imageUrl = ApiConstants.baseUrl + imageUrls[index];
              return BlocProvider(
                create: (context) =>
                    getIt<NetworkImageCubit>()..fetchImage(imageUrl),
                child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ImageLoaded) {
                      return Image.memory(
                        state.imageData,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      );
                    } else if (state is ImageError) {
                      return Center(
                        child: Icon(Icons.error, color: Colors.red, size: 60),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
