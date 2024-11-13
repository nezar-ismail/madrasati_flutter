import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/models/feedback/feedback.dart';
import 'package:madrasati/data/models/feedback/feedback_res.dart';
import 'package:madrasati/data/models/school_models/schoolPage/school_profile_page.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/school_service.dart';
import 'package:madrasati/data/utils/custom_logs.dart';

part 'school_info_state.dart';

class SchoolInfoCubit extends Cubit<SchoolInfoState> {
  final SchoolService _schoolService = getIt<SchoolService>();
  int currentPage = 0;
  bool hasMore = true;
  bool isFetching = false;
  List<FeedbackContent> feedbackContents = [];
  SchoolInfoCubit() : super(SchoolInfoInitial());

  /// Get school information by schoolId
  ///
  /// Emits [SchoolInfoLoading] state, then
  /// - [SchoolInfoLoaded] with [SchoolProfilepage] if the request is successful
  /// - [SchoolInfoError] if the request fails
  Future<void> getSchoolInfo( {required String schoolId}) async {
    emit(SchoolInfoLoading());
    try {
      final response = await _schoolService.getSchoolById(schoolId: schoolId, token: await SecureStorageApi().getAccessToken()??'');
    if (response is SchoolProfilepage) {
      emit(SchoolInfoLoaded(schoolProfilePage: response));
    } else {
      emit(SchoolInfoError(message: response.toString()));
    }
    }catch (e) {
      logError(e.toString());
      emit(SchoolInfoError(message: e.toString()));
    }    
  }


    Future<void> fetchFeedback(String schoolId) async {
    if (!hasMore || isFetching)return; // Stop fetching if no more pages or already fetching
    isFetching = true; // Set fetching flag to true to prevent multiple calls
    emit(SchoolInfoLoading());
    try {
      final response = await _schoolService.getAllFeedback(
          schoolId: schoolId,
          token: await SecureStorageApi.instance.getAccessToken() ?? "",
          page: currentPage,
          size: 10);
      if (response is FeedbackData) {
        currentPage++;
        hasMore = !response.last;
        feedbackContents.addAll(response.content);
        isFetching = false;
        emit(FeedbackLoaded(
            feedbackContents: feedbackContents,
            hasMore: hasMore)); // Emit state with the updated list
      }
    } catch (e) {
      emit(SchoolInfoError(message: e.toString()));
    }
  }
}
