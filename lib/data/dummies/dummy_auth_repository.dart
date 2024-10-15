import 'package:gps_tracker/data/repositories/auth_repository.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/entities/user.dart';
import 'package:gps_tracker/presentation/misc/token_helper.dart';

class DummyAuthRepository implements AuthRepository {
  @override
  Future<bool> getLoggedInUser() async {
    await Future.delayed(const Duration(seconds: 2));
    var result = await TokenHelper().getLoginStatus();
    return result;
  }

  @override
  Future<Result<User>> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    await TokenHelper().setLoginStatus(true);

    return const Result.success(User(id: 1, name: 'Kirara Bernstein', email: 'kirara@gmail.com'));
  }

  @override
  Future<Result<void>> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    await TokenHelper().setLoginStatus(false);
    return const Result.success(null);
  }

  @override
  Future<Result<User>> getSession() async {
    await Future.delayed(const Duration(seconds: 1));

    return const Result.success(const User(id: 1, name: 'Kirara Bernstein', email: 'kirara@gmail.com'));
  }
  
  @override
  Future<Result<String>> generateToken({required String cookies}) {
    // TODO: implement generateToken
    throw UnimplementedError();
  }
}
