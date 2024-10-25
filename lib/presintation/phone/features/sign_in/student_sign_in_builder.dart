import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/utils/coustum_loading.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:madrasati/presintation/phone/features/sign_in/student_sign_in_ui.dart';
import 'package:madrasati/presintation/phone/features/student/view/student_home.dart';

class StudentSignInBuilder extends StatelessWidget {
  const StudentSignInBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInCubit>(),
      child: BlocConsumer<SignInCubit, SignInState>(
        builder: (context, state) {
          if (state is SignInLoading) {
            return CustomLoading();
          }
          return StudentSignInUi();
        },
        listener: (BuildContext context, SignInState state) {
          if (state is SignInSuccess) {
            final overlayState = Overlay.of(context);
            customSnackbar(
                overlayState, "Sign in successfully", Icons.done, Colors.blue);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StudentHomePage()));
          } else if (state is SignInError) {
            final overlayState = Overlay.of(context);
            customSnackbar(
                overlayState, "Sign in failed", Icons.error, Colors.red);
          } else if (state is SignInUnAuthorized) {
            final overlayState = Overlay.of(context);
            customSnackbar(overlayState, "Please check your email and password",
                Icons.error, Colors.red);
          }
        },
      ),
    );
  }
}
