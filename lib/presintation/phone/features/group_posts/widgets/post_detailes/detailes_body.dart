import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';

class DetailesBody extends StatelessWidget {
  const DetailesBody({
    super.key,
    required this.caption,
    required this.withImage,
    this.imagePost,
  });

  final String caption;
  final bool withImage;
  final List<dynamic>? imagePost;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          if (withImage && imagePost != null && imagePost!.isNotEmpty)
            SizedBox(
              height: 200, // Adjust height for preview images
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePost!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showImageSlider(context, imagePost!, index),
                    child: BlocProvider(
                      create: (context) => getIt<NetworkImageCubit>()
                        ..fetchImage(ApiConstants.baseUrl + imagePost![index]),
                      child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
                        builder: (context, state) {
                          if (state is ImageLoading) {
                            return Container(
                              width: 200,
                              color: const Color.fromARGB(255, 60, 60, 60),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is ImageLoaded) {
                            return Container(
                              width: 200,
                              margin: const EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(state.imageData),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          } else if (state is ImageError) {
                            return Container(
                              width: 200,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.error),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}

void _showImageSlider(BuildContext context, List<dynamic> imageUrls, int initialIndex) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.black, // Dark background for full-screen viewing
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
              create: (context) => getIt<NetworkImageCubit>()..fetchImage(imageUrl),
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
      );
    },
  );
}
