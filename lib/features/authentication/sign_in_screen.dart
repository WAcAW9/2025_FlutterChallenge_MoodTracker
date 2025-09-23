// 로그인 스크린
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/authentication/sign_up_screen.dart';
import 'package:mood_tracker/features/authentication/view_models/login_view_model.dart';
import 'package:mood_tracker/features/authentication/widgets/form_button.dart';
import 'package:mood_tracker/features/constants/gaps.dart';
import 'package:mood_tracker/features/constants/sizes.dart';

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
      }
    }
  }

  void _onTap(BuildContext context) async {
    context.go(SignUpScreen.routeName);
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gaps.v96,
                Text(
                  'Mood Tracker',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: Sizes.size44,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Sizes.size28),
                ),
                Gaps.v28,

                // 로그인 작성칸
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                      Gaps.v28,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("첫 방문이신가요? "),
                          GestureDetector(
                            onTap: () => _onTap(context),
                            child: const Text(
                              "회원가입",
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
