import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Result<User>> login({
    required String email,
    required String password,
  });

  Future<Result<User>> getSession();
  Future<Result<void>> logout();
  Future<bool> getLoggedInUser();
  Future<Result<String>> generateToken({required String cookies});
}
