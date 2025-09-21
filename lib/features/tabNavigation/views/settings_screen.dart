import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/authentication/repos/authentication_repo.dart';

class UserScreen extends ConsumerWidget {
  static const routeName = "/user";
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              SwitchListTile.adaptive(
                value: false,
                onChanged: (value) {},
                title: const Text("Enable notifications"),
                subtitle: const Text("앱 알림을 허용합니다"),
              ),
              CheckboxListTile(
                activeColor: Colors.black,
                value: false,
                onChanged: (value) {},
                title: const Text("Marketing emails"),
                subtitle: const Text("마케팅 수신에 동의합니다"),
              ),

              ListTile(
                title: const Text("Log out"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text("Are you sure?"),
                      actions: [
                        CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          onPressed: () => ref.read(authRepo).logOut(),
                          child: const Text("Log out"),
                        ),
                        CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("cancel"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const AboutListTile(applicationVersion: "1.0"),
            ],
          ),
        ),
      ],
    );
  }
}
