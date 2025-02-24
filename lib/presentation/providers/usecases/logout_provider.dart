import 'package:gps_tracker/domain/usecase/logout/logout.dart';
import 'package:gps_tracker/presentation/providers/repositories/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) => Logout(authRepository: ref.watch(authRepositoryProvider));
