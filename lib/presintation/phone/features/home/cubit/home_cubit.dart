import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/models/school_models/school_card.dart';
import 'package:madrasati/data/models/school_models/school_home_page_response.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/school_service.dart';

part 'home_state.dart';

class SchoolPagingCubit extends Cubit<SchoolPagingState> {
  final SchoolService schoolService = getIt<SchoolService>();
  int currentPage = 0;
  bool hasMore = true;
  bool isFetching =
      false; // Added flag to prevent multiple simultaneous requests
  List<SchoolCard> schools = []; // Store widgets for displaying
  ScrollController scrollController = ScrollController();

  SchoolPagingCubit() : super(SchoolInitial());

  Future<void> fetchSchools() async {
  if (!hasMore || isFetching) return; // Stop fetching if no more pages or already fetching

  isFetching = true; // Set fetching flag to true to prevent multiple calls
  emit(SchoolLoading());

  try {
    final response = await schoolService.getAllSchools(
      page: currentPage,
      size: 10, // Adjust size as needed
      token: await SecureStorageApi.instance.getAccessToken() ?? "",
    );

    if (response is SchoolHomePage) {
      currentPage++;
      hasMore = !response.last; // Update hasMore based on response
      
      // Add fetched raw data to the list of schools
      schools.addAll(response.content);
      
      // Emit raw data instead of widgets
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
