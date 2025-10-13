import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

SnackBar failureSnackBar({required String title, required String message}) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.zero,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.failure,
    ),
  );
}

SnackBar successSnackBar({required String title, required String message}) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.zero,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.success,
    ),
  );
}
