import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/authentication/repos/authentication_repo.dart';
import 'package:mood_tracker/features/authentication/sign_in_screen.dart';
import 'package:mood_tracker/features/authentication/sign_up_screen.dart';
import 'package:mood_tracker/features/tabNavigation/views/tabNavigation_main.dart';
import 'package:mood_tracker/features/tabNavigation/views/settings_screen.dart';

final routerProvider = Provider((ref) {
  ref.watch(authSate);
  return GoRouter(
    initialLocation: "/home",
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
          return UserScreen();
        },
      ),

      GoRoute(
        path: TabnavigationMain.routeName,
        builder: (context, state) => const TabnavigationMain(),
      ),
    ],
  );
});
