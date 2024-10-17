import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(12),
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: SpinKitThreeInOut(
            size: 24,
            color: AppColors.secondary,
          ),
        ),
      );
    },
  );
}

// Fungsi untuk menutup loading dialog
void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop(); // Tutup dialog
}
