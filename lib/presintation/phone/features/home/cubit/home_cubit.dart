import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:madrasati/data/models/school_models/school_home_page_response.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/school_service.dart';
import 'package:madrasati/presintation/phone/features/home/widgets/school_card.dart';

part 'home_state.dart';

class SchoolCubit extends Cubit<SchoolState> {
  final SchoolService schoolService;
  int currentPage = 0;
  bool hasMore = true;
  List<Widget> schools = []; // Store widgets for displaying

  SchoolCubit(this.schoolService) : super(SchoolInitial());

  Future<void> fetchSchools() async {
    if (!hasMore) return; // Stop fetching if no more pages

    emit(SchoolLoading());

    try {
      final response = await schoolService.getAllSchools(
          page: currentPage, size: 10, token: await SecureStorageApi().getAccessToken()?? ""); // Adjust size as needed
      if (response is SchoolHomePage) {
        // Make sure to check the response type
        currentPage++;
        hasMore = !response.empty; // Update hasMore based on response
        // Convert the fetched data to SchoolCard widgets
        schools.addAll(response.content
            .map((school) => SchoolCard(
                  key: ValueKey(school.id),
                  schoolName: school.schoolName,
                  schoolType: school.schoolType,
                  rating: school.averageRating?? 0.0,
                ))
            .toList());
        emit(SchoolLoaded(schools: schools, hasMore: hasMore));
      } else {
        emit(SchoolError('Failed to load schools'));
      }
    } catch (e) {
      emit(SchoolError(e.toString()));
    }
  }
}
