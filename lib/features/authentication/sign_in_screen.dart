// 로그인 스크린
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/authentication/sign_up_screen.dart';
import 'package:mood_tracker/features/tabNavigation/views/user_screen.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = "/";

  const SignInScreen({super.key});

  void _onTap(BuildContext context) async {
    context.go(SignUpScreen.routeName);
  }

  void _goMain(BuildContext context, String username) {
    context.go(UserScreen.routeName, extra: UserScreenArgs(username: username));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인 스크린')),
      body: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _onTap(context),
              icon: Icon(Icons.adb_outlined),
            ),
            Text('로그인 스크린'),
            IconButton(
              onPressed: () => _goMain(context, "wacw"),
              icon: Icon(Icons.abc),
            ),
          ],
        ),
      ),
    );
  }
}
