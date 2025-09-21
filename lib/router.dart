import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/authentication/repos/authentication_repo.dart';
import 'package:mood_tracker/features/authentication/sign_in_screen.dart';
import 'package:mood_tracker/features/authentication/sign_up_screen.dart';
import 'package:mood_tracker/features/tabNavigation/views/user_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/user",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != SignUpScreen.routeName &&
            state.subloc != SignInScreen.routeName) {
          return SignUpScreen.routeName;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: SignInScreen.routeName,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: SignUpScreen.routeName,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: UserScreen.routeName,
        builder: (context, state) {
          final args = state.extra as UserScreenArgs;
          return UserScreen(username: args.username);
        },
      ),
    ],
  );
});
