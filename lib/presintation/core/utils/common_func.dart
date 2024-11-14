import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/presintation/core/service/cubit/logout_cubit.dart';
import 'package:madrasati/presintation/phone/features/sign_in/role_desesion.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void customSnackbar(
    OverlayState overlayState, String message, IconData icon, Color color) {
  return showTopSnackBar(
    overlayState,
    CustomSnackBar.success(
      message: message,
      backgroundColor: color,
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Icon(
          icon,
          color: Colors.grey.shade200.withOpacity(0.8),
          size: scaleText(50, overlayState.context),
        ),
      ),
      textStyle: const TextStyle(color: Colors.white, fontFamily: 'Roboto'),
    ),
  );
}

double scaleText(double size, BuildContext context) {
  // ignore: deprecated_member_use
  return size * MediaQuery.of(context).textScaleFactor;
}

FittedBox loggedOut(BuildContext context) {
  return FittedBox(
    fit: BoxFit.contain,
    child: IconButton(
      icon: const Icon(Icons.logout),
      iconSize: 40,
      color: Colors.white,
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    BlocProvider(
                      create: (context) => LogoutCubit(),
                      child: BlocConsumer<LogoutCubit, LogoutState>(
                        listener: (context, state) {
                          if (state is LogoutSuccess) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RoleDesesion()),
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                        builder: (context, state) {
                          return TextButton(
                            child: const Text('Logout'),
                            onPressed: () async {
                              await context.read<LogoutCubit>().logout();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ));
      },
    ),
  );
}
