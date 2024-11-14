import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';

part 'network_image_state.dart';

class NetworkImageCubit extends Cubit<NetworkImageState> {
  final API _dio = getIt.get<API>();

  NetworkImageCubit() : super(NetworkImageInitial());

  /// Fetches the image from the network.
  ///
  /// If [imageUrl] is null or empty, emits [ImageError] with
  /// "Invalid image URL".
  ///
  /// Otherwise, emits [ImageLoading] and then attempts to fetch the
  /// image. If the fetch is successful, emits [ImageLoaded] with the
  /// image data. If the fetch fails, emits [ImageError] with the error
  /// message.
  Future<void> fetchImage(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) {
      emit(ImageError("Invalid image URL"));
      return;
    }
    emit(ImageLoading());
    try {
      final response = await _dio.getImage(imageUrl, headers: {
        'Authorization':
            'Bearer ${await SecureStorageApi.instance.getAccessToken() ?? ''}',
      });
      emit(ImageLoaded(Uint8List.fromList(response.data!)));
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }
}
