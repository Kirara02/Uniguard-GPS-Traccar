import 'package:gps_tracker/domain/usecase/login/login.dart';
import 'package:gps_tracker/presentation/providers/repositories/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(authRepository: ref.watch(authRepositoryProvider));
