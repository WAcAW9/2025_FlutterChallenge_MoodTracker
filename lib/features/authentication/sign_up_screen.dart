// 회원가입 스크린
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/authentication/sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "/sign_up";
  const SignUpScreen({super.key});

  void _onTap(BuildContext context) async {
    context.go(SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("회원가입 스크린")),
      body: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _onTap(context),
              icon: Icon(Icons.adb_outlined),
            ),
            Text('회원가입 스크린'),
          ],
        ),
      ),
    );
  }
}
