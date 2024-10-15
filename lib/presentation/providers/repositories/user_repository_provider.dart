import 'package:gps_tracker/data/api/api_user_repository.dart';
import 'package:gps_tracker/data/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) => ApiUserRepository();
