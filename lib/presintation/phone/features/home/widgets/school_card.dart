import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/phone/features/home/widgets/school_card_info.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/school_details_page.dart';

class SchoolCard extends StatelessWidget {
  final String schoolName;
  final String schoolType;
  final double rating;
  final String id;

  const SchoolCard({
    super.key,
    required this.schoolName,
    required this.schoolType,
    required this.rating,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // getIt<SchoolInfoCubit>().getSchoolInfo(schoolId: id);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => getIt<SchoolInfoCubit>()
                      ..getSchoolInfo(schoolId: id),
                    child: SchoolDetailPage(),
                  )),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('asset/static/image/school.png'),
            fit: BoxFit.contain,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white12,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets +
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SchoolCardInfo(
              schoolName: schoolName,
              schoolType: schoolType,
              rating: rating,
            ),
          ),
        ),
      ),
    );
  }
}
