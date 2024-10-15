import 'package:gps_tracker/data/api/api_auth_repository.dart';
import 'package:gps_tracker/data/repositories/user_repository.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/entities/user.dart';
import 'package:gps_tracker/presentation/misc/api_client.dart';

class ApiUserRepository implements UserRepository {
  late final ApiClient _apiClient;

  ApiUserRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  @override
  Future<Result<User>> getUser() async {
    var result = await ApiAuthRepository().getSession();

    if (result.isSuccess) {
      return Result.success(result.resultValue!);
    } else {
      return const Result.failed("Failed get session");
    }
  }
}
