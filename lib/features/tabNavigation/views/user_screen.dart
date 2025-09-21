import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/settings/settings_screen.dart';

class UserScreenArgs {
  final String username;
  UserScreenArgs({required this.username});
}

class UserScreen extends StatelessWidget {
  final String username;
  static const routeName = "/user";

  const UserScreen({super.key, required this.username});

  void _pressSettingButton(BuildContext context) async {
    context.push(SettingsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            onPressed: () => _pressSettingButton(context),
            icon: Icon(Icons.settings),
          ),
          Text('${username}, 반갑습니다.'),
        ],
      ),
    );
  }
}
