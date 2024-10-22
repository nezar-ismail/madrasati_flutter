import 'package:flutter/material.dart';
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