import 'package:go_router/go_router.dart';
import 'package:gps_tracker/presentation/misc/app_routes.dart';
import 'package:gps_tracker/presentation/pages/device/device_page.dart';
import 'package:gps_tracker/presentation/pages/login/login_page.dart';
import 'package:gps_tracker/presentation/pages/main/main_page.dart';
import 'package:gps_tracker/presentation/pages/splash/splash_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      routes: [
        GoRoute(
          path: Routes.SPLASH,
          name: "/",
          builder: (context, state) {
            return const SplashPage();
          },
        ),
        GoRoute(
          path: Routes.LOGIN,
          name: "login",
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: Routes.MAIN,
          name: "main",
          builder: (context, state) {
            return const MainPage();
          },
        ),
        GoRoute(
          path: Routes.DEVICE,
          name: "device",
          builder: (context, state) {
            return const DevicePage();
          },
        ),
      ],
      initialLocation: Routes.SPLASH,
      debugLogDiagnostics: false,
    );
