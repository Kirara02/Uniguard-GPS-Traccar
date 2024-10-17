import 'package:gps_tracker/domain/usecase/get_logged_in_user/get_logged_in_user.dart';
import 'package:gps_tracker/presentation/providers/repositories/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user_provider.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) =>
    GetLoggedInUser(authRepository: ref.watch(authRepositoryProvider));
