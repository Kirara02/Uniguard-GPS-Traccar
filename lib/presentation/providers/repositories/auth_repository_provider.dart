import 'package:gps_tracker/data/api/api_auth_repository.dart';
import 'package:gps_tracker/data/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => ApiAuthRepository();
