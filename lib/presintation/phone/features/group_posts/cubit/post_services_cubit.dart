import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/group_post_service.dart';

part 'post_services_state.dart';

class PostServicesCubit extends Cubit<PostServicesState> {
  final GroupPostService _postService;
  PostServicesCubit( this._postService) : super(PostServicesInitial());


  Future<void> likePost ( String postId) async {
    emit(PostServicesLoading());
    try {
      final response = await _postService.addLike(postId: postId, token: await SecureStorageApi.instance.getAccessToken() ?? "");
      if (response is EmptyResponse) {
        emit(LikeAdded());
      }else{
        emit(PostServicesError(message: response.toString()));
      }
    } catch (e) {
      emit(PostServicesError(message: e.toString()));
    }
  }


  Future<void> unlikePost ( String postId) async {
    emit(PostServicesLoading());
    try {
      final response = await _postService.removeLike(postId: postId, token: await SecureStorageApi.instance.getAccessToken() ?? "");
      if (response is EmptyResponse) {
        emit(LikeRemoved());
      }else{
        emit(PostServicesError(message: response.toString()));
      }
    } catch (e) {
      emit(PostServicesError(message: e.toString()));
    }
  }
}
