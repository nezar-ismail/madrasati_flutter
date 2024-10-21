import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/presintation/core/utils/coustum_loading.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/home/home.dart';
import 'package:madrasati/presintation/phone/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:madrasati/presintation/phone/features/sign_in/school_sign_in_ui.dart';

class SchoolSignInBuilder extends StatelessWidget {
  const SchoolSignInBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInCubit>(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (BuildContext context, SignInState state) {
          if (state is SignInSuccess) {
            final overlayState = Overlay.of(context);
            customSnackbar(overlayState, "Sign in successfully", Icons.done,
                Colors.orange);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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
        builder: (context, state) {
          if (state is SignInLoading) {
            return CustomLoading();
          }
          return SchoolSignInUi();
        },
      ),
    );
  }
}
