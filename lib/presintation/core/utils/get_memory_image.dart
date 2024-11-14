
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';

class GetMemoryImage extends StatelessWidget {
  const GetMemoryImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkImageCubit, NetworkImageState>(
      builder: (context, state) {
        if (state is ImageLoading) {
          return Container(
            color: const Color.fromARGB(255, 60, 60, 60),
            child: const CircularProgressIndicator(),
          );
        } else if (state is ImageLoaded) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: MemoryImage(state.imageData),
              fit: BoxFit.cover,
            )),
          );
        } else if (state is ImageError) {
          return Container(
            color: Colors.grey[300],
            child: LoadingIndicator(indicatorType: Indicator.ballRotateChase, colors: const [Colors.black, Colors.red, Colors.orange, Colors.yellow, Colors.blue, Colors.green], pathBackgroundColor: Colors.white,),
          );
        }
        return Container(
          color: Colors.grey[300],
        ); // Placeholder for initial state
      },
    );
  }
}
