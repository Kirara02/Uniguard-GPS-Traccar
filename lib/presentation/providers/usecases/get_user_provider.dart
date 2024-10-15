import 'package:gps_tracker/domain/usecase/get_user/get_user.dart';
import 'package:gps_tracker/presentation/providers/repositories/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_user_provider.g.dart';

@riverpod
GetUser getUser(GetUserRef ref) => GetUser(userRepository: ref.watch(userRepositoryProvider));
