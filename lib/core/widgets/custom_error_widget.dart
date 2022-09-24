import 'package:quote/config/locale/app_localizations.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import 'package:quote/core/utils/app_colors.dart';
import 'package:quote/core/utils/media_query_values.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
    this.onPressed,
    this.message,
  }) : super(key: key);

  final void Function()? onPressed;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber,
            color: AppColors.primary,
            size: 150,
          ),
          SizedBox(height: 10),
          Text(
            message ?? AppLocalizations.of(context)?.translate(AppStrings.somethingWentWrong) ?? "",
            style: theme.headline3,
          ),
          SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)?.translate(AppStrings.tryAgain) ?? "",
            style: theme.headline2,
          ),
          SizedBox(height: 10),
          Container(
            height: 45,
            width: context.width * 0.45,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(AppLocalizations.of(context)?.translate(AppStrings.reloadScreen) ?? ""),
            ),
          ),
        ],
      ),
    );
  }
}
