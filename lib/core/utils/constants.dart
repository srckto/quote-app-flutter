import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quote/config/locale/app_localizations.dart';
import 'package:quote/core/utils/app_colors.dart';
import 'package:quote/core/utils/app_strings.dart';

class Constants {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)?.translate(AppStrings.ok) ?? "",
            ),
          ),
        ],
      ),
    );
  }

  static void showToast(String message, Color color) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: color,
    );
  }

  static Widget loading() {
    return SpinKitRotatingCircle(
      color: AppColors.primary,
      size: 50.0,
    );
  }
}
