import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/entities/user.dart';
import 'package:gps_tracker/domain/usecase/get_logged_in_user/get_logged_in_user.dart';
import 'package:gps_tracker/domain/usecase/login/login.dart';
import 'package:gps_tracker/domain/usecase/login/login_params.dart';
import 'package:gps_tracker/domain/usecase/logout/logout.dart';
import 'package:gps_tracker/presentation/providers/api/devices_provider.dart';
import 'package:gps_tracker/presentation/providers/usecases/get_logged_in_user_provider.dart';
import 'package:gps_tracker/presentation/providers/usecases/login_provider.dart';
import 'package:gps_tracker/presentation/providers/usecases/logout_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  FutureOr<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(value: final user):
        _initialize();
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var result = await login(LoginParams(email: email, password: password));

    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);
        _initialize();
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> logout() async {
    Logout logout = ref.read(logoutProvider);
    var result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  void _initialize() {
    ref.read(devicesProvider.notifier).getDevices();
  }
}
