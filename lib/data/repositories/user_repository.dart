import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Result<User>> getUser();
}
