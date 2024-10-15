import 'package:gps_tracker/data/repositories/user_repository.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/entities/user.dart';

class DummyUserRepository implements UserRepository {
  @override
  Future<Result<User>> getUser() async {
    await Future.delayed(const Duration(seconds: 1));

    return Result.success(User(id: 1, name: 'Kirara Bernstein', email: 'kirara@gmail.com'));
  }
}
