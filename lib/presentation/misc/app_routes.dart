abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const MAIN = _Paths.MAIN;
  static const DEVICE = _Paths.DEVICE;
}

abstract class _Paths {
  _Paths._();

  static const SPLASH = '/';
  static const MAIN = '/main';
  static const LOGIN = '/login';
  static const DEVICE = '/device';
}
