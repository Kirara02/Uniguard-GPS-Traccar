import 'package:gps_tracker/data/repositories/user_repository.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/entities/user.dart';
import 'package:gps_tracker/domain/usecase/usecase.dart';

class GetUser implements UseCase<Result<User>, void> {
  final UserRepository _userRepository;

  GetUser({required UserRepository userRepository}) : _userRepository = userRepository;
  @override
  Future<Result<User>> call(_) async {
    var result = await _userRepository.getUser();

    return switch (result) {
      Success(:final value) => Result.success(value),
      Failed(:final message) => Result.failed(message)
    };
  }
}
