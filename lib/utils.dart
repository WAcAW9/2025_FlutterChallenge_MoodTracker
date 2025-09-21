import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  String message = "알 수 없는 오류가 발생했습니다.";

  // error의 실제 타입을 확인하여 메시지를 설정합니다.
  if (error is FirebaseException) {
    message = error.message ?? "Firebase 오류가 발생했습니다.";
  } else if (error is TypeError) {
    message = "타입 오류가 발생했습니다. 코드의 데이터 타입을 확인해주세요.";
  }
  // 다른 오류 타입에 대한 처리도 추가할 수 있습니다.

  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
