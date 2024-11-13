import 'package:flutter/material.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';

Column schoolInfo(BuildContext context, SchoolInfoLoaded state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.phone, color: Colors.grey),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Text(state.schoolProfilePage.schoolPhoneNumber,
              style: TextStyle(fontFamily: 'Roboto')),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.location_on, color: Colors.grey),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Text(state.schoolProfilePage.schoolLocation,
              style: TextStyle(fontFamily: 'Roboto')),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.star, color: Colors.grey),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Text(state.schoolProfilePage.averageRating.toString(),
              style: TextStyle(fontFamily: 'Roboto')),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.people, color: Colors.grey),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Text(state.schoolProfilePage.schoolStudentCount.toString(),
              style: TextStyle(fontFamily: 'Roboto')),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.email, color: Colors.grey),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Text(state.schoolProfilePage.schoolEmail,
              style: TextStyle(fontFamily: 'Roboto')),
        ],
      ),
    ],
  );
}
