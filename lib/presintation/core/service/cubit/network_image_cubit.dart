
import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';

part 'network_image_state.dart';

class NetworkImageCubit extends Cubit<NetworkImageState> {
  final API _dio;

  NetworkImageCubit(this._dio) : super(NetworkImageInitial());

  Future<void> fetchImage(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) {
      emit(ImageError("Invalid image URL"));
      return;
    }
    emit(ImageLoading());
    try {
      final response = await _dio.getImage(
        imageUrl,
        headers: {
          'Authorization': 'Bearer ${await SecureStorageApi.instance.getAccessToken()??''}',
        }
      
      );
      emit(ImageLoaded(Uint8List.fromList(response.data! )));
    } catch (e) {
    log( e.toString());
    emit(ImageError(e.toString()));
    }
  }
}
