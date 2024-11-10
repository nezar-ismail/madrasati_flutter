import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:madrasati/data/models/school_models/school_home_page_response.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/school_service.dart';
import 'package:madrasati/presintation/phone/features/home/widgets/school_card.dart';

part 'home_state.dart';

class SchoolPagingCubit extends Cubit<SchoolPagingState> {
  final SchoolService schoolService;
  int currentPage = 0;
  bool hasMore = true;
  bool isFetching =
      false; // Added flag to prevent multiple simultaneous requests
  List<Widget> schools = []; // Store widgets for displaying
  ScrollController scrollController = ScrollController();

  SchoolPagingCubit(this.schoolService) : super(SchoolInitial());

  /// Fetches a page of schools from the server and updates the state with the 
  /// fetched schools. If there are no more pages to fetch, [hasMore] is set 
  /// to false. The fetched data is converted to `SchoolCard` widgets and added 
  /// to the [schools] list.
  ///
  /// This method is idempotent, meaning it can be safely called multiple times,
  /// and it will only fetch new schools if there are more schools to fetch.
  ///
  /// Emits a [SchoolLoading] state before the fetching starts. If the fetching 
  /// is successful, emits a [SchoolLoaded] state with the fetched schools and 
  /// [hasMore] flag. If the fetching fails, emits a [SchoolError] state with 
  /// the error message.
  ///
  /// Uses a flag to prevent multiple simultaneous requests.
  Future<void> fetchSchools() async {
    if (!hasMore || isFetching) return; // Stop fetching if no more pages or already fetching

    isFetching = true; // Set fetching flag to true to prevent multiple calls
    emit(SchoolLoading());

    try {
      final response = await schoolService.getAllSchools(
          page: currentPage,
          size: 10, // Adjust size as needed
          token: await SecureStorageApi.instance.getAccessToken() ?? "");
      if (response is SchoolHomePage) {
        currentPage++;
        hasMore = !response.last; // Update hasMore based on response
        // Convert the fetched data to SchoolCard widgets
        schools.addAll(response.content
            .map((school) => SchoolCard(
                  key: ValueKey(school.id),
                  schoolName: school.schoolName,
                  schoolType: school.schoolType,
                  rating: school.averageRating ?? 0.0,
                  id: school.id,
                  imagePath: school.schoolCoverImage,
                ))
            .toList());
            
        emit(SchoolLoaded(schools: schools, hasMore: hasMore));
      } else {
        emit(SchoolError('Failed to load schools'));
      }
    } catch (e) {
      emit(SchoolError(e.toString()));
    } finally {
      isFetching = false; // Reset the fetching flag when done
    }
  }

  @override
  Future<void> close() {
    scrollController
        .dispose(); // Dispose of ScrollController when Cubit is closed
    return super.close();
  }
}
