import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/api_constant.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(12.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 10),
          if (withImage && imagePost != null && imagePost!.isNotEmpty)
            SizedBox(
              height: screenWidth * 0.5, // Responsive height for images
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePost!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showImageSlider(context, imagePost!, index),
                    child: _buildImagePreview(ApiConstants.baseUrl + imagePost![index]),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(String imageUrl) {
    return BlocProvider(
      create: (context) => NetworkImageCubit()..fetchImage(imageUrl),
      child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
        builder: (context, state) {
          if (state is ImageLoading) {
            return _buildLoadingImage();
          } else if (state is ImageLoaded) {
            return _buildLoadedImage(state.imageData);
          } else if (state is ImageError) {
            return _buildErrorImage();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingImage() {
    return Container(
      width: 200,
      color: const Color.fromARGB(255, 60, 60, 60),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildLoadedImage(Uint8List imageData) {
    return Container(
      width: 200,
      height: 200,
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: MemoryImage(imageData),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildErrorImage() {
    return Container(
      width: 200,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.error),
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
        backgroundColor: Colors.black,
        child: CarouselSlider.builder(
          itemCount: imageUrls.length,
          options: CarouselOptions(
            initialPage: initialIndex,
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
          ),
          itemBuilder: (context, index, _) {
            final imageUrl = ApiConstants.baseUrl + imageUrls[index];
            return BlocProvider(
              create: (context) => NetworkImageCubit()..fetchImage(imageUrl),
              child: BlocBuilder<NetworkImageCubit, NetworkImageState>(
                builder: (context, state) {
                  if (state is ImageLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ImageLoaded) {
                    return Image.memory(
                      state.imageData,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
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
