import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/school_details_page.dart';
import 'package:madrasati/presintation/phone/features/sign_in/role_desesion.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';
import 'package:madrasati/presintation/phone/features/student/view/student_home.dart';

import '../cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) {
        final cubit = SplashCubit();
        Future.delayed(const Duration(seconds: 3), () async {
          await cubit.checkServer();
        });
        return cubit;
      },
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is InternetError) {
            context.read<SplashCubit>().setLoadding();
          } else if (state is InternetConnected) {
            context.read<SplashCubit>().loggedIn();
          } else if (state is SchoolAlreadyLogin) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => SchoolInfoCubit()
                    ..getSchoolInfo(
                        schoolId: getIt<UserProfileCubit>().state!.schoolId!),
                  child: SchoolDetailPage(
                    isManeger: true,
                  ),
                ),
              ),
            );
          } else if (state is StudentAlreadyLogin) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const StudentHomePage()),
              (Route<dynamic> route) => false,
            );
          } else if (state is GuestAlreadyLogin) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RoleDesesion()),
              (Route<dynamic> route) => false,
            );
          } else if (state is UserLoggedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RoleDesesion()),
              (Route<dynamic> route) => false,
            );
          } else if (state is SplashError) {
            customSnackbar(Overlay.of(context),
                "Server Error, Please try again", Icons.error, Colors.red);
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<SplashCubit, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoading) {
                      return IconButton(
                        onPressed: () {
                          context.read<SplashCubit>().setInit();
                          context.read<SplashCubit>().checkServer();
                        },
                        icon: const Icon(Icons.refresh),
                        iconSize: screenWidth * 0.12, // Responsive size
                        color: Colors.blue,
                      );
                    }

                    return Container(
                      height: screenHeight,
                      width: screenWidth,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Center(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 70.0,
                            fontFamily: 'Canterbury',
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ScaleAnimatedText('Welcome',
                                  duration: Duration(milliseconds: 500)),
                              ScaleAnimatedText('To',
                                  duration: Duration(milliseconds: 200)),
                              ScaleAnimatedText('Madrasati',
                                  duration: Duration(milliseconds: 500)),
                            ],
                            isRepeatingAnimation: true,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
