import 'package:gps_tracker/data/repositories/auth_repository.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/usecase/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final AuthRepository _authRepository;

  Logout({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Result<void>> call(_) async {
    return await _authRepository.logout();
  }
}
