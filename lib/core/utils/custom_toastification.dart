import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showErrorToastification({required String error}) {
  toastification.show(
    type: ToastificationType.error,
  title: Text(error),
  autoCloseDuration: const Duration(seconds: 4),
);
}


void showSuccessToastification({required String success}) {
  toastification.show(
    type: ToastificationType.success,
  title: Text(success),
  autoCloseDuration: const Duration(seconds: 4),
);
}
