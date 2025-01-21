import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void showBlocSnackbar(BuildContext context, String message) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  });
}
