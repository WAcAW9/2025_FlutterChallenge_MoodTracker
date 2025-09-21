import 'package:flutter/material.dart';

class UserScreenArgs {
  final String username;
  UserScreenArgs({required this.username});
}

class UserScreen extends StatelessWidget {
  final String username;
  static const routeName = "/user";

  const UserScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('${username}, 반갑습니다.')));
  }
}
