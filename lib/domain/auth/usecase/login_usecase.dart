import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/user_repo.dart';

class LoginUsecase implements UseCase<UserEntity, Map<String, String>> {
  final UserRepository userRepository;

  LoginUsecase(this.userRepository);

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await userRepository.login(params['email']!, params['password']!);
  }
}
