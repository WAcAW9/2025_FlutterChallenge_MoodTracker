// 회원가입 스크린
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/authentication/sign_in_screen.dart';
import 'package:mood_tracker/features/authentication/view_models/signup_view_model.dart';
import 'package:mood_tracker/features/authentication/widgets/form_button.dart';
import 'package:mood_tracker/features/constants/gaps.dart';
import 'package:mood_tracker/features/constants/sizes.dart';
import 'package:mood_tracker/features/tabNavigation/views/user_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = "/sign_up";
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onTap(BuildContext context) async {
    context.go(SignInScreen.routeName);
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null || !_isPasswordValid()) {
      return;
    }
    ref.read(signUpForm.notifier).state = {
      "email": _email,
      "password": _password,
    };
    ref.read(signUpProvider.notifier).signUp(context);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const UserScreen(username: "wacaw"),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(title: Text("회원가입 스크린")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _onTap(context),
              icon: Icon(Icons.adb_outlined),
            ),
            Text('회원가입 스크린'),

            // 이메일 입력란
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: _onSubmit,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _isEmailValid(),
                ),
              ),
            ),

            // 비밀번호 입력란
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
              child: TextField(
                controller: _passwordController,
                onEditingComplete: _onSubmit,
                obscureText: _obscureText,
                autocorrect: false,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: Icon(Icons.close),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: Icon(Icons.remove_red_eye_outlined),
                      ),
                    ],
                  ),
                  hint: Text("password"),
                ),
              ),
            ),
            Gaps.v28,
            GestureDetector(
              onTap: _onSubmit,
              child: FormButton(
                disabled:
                    _email.isEmpty ||
                    _isEmailValid() != null ||
                    !_isPasswordValid() ||
                    ref.watch(signUpProvider).isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
