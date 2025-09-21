// 로그인 스크린
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/authentication/sign_up_screen.dart';
import 'package:mood_tracker/features/authentication/view_models/login_view_model.dart';
import 'package:mood_tracker/features/authentication/widgets/form_button.dart';
import 'package:mood_tracker/features/constants/sizes.dart';
import 'package:mood_tracker/features/tabNavigation/views/user_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const routeName = "/";

  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref
            .read(loginProvider.notifier)
            .login(formData["email"]!, formData["password"]!, context);
        // context.goNamed(InterestsScreen.routeName);
      }
    }
  }

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
      body: Center(
        child: Column(
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

            // 로그인 작성칸
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Gaps.v28,
                  // 이메일
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Plase write your email";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['email'] = newValue;
                      }
                    },
                  ),
                  Gaps.v16,
                  // 비밀번호
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Plase write your password";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['password'] = newValue;
                      }
                    },
                  ),
                  Gaps.v28,
                  GestureDetector(
                    onTap: _onSubmitTap,
                    child: FormButton(
                      disabled: ref.watch(loginProvider).isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
