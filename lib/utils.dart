import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  String message = "";
  if (error is FirebaseException) {
    message = error.message ?? "Firebase 오류가 발생했습니다.";
  }
}
