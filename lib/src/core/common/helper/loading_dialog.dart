import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Center(child: Image.asset(loadingGif)),
  );
}
