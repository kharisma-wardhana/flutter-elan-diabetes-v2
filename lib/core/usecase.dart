import 'package:dartz/dartz.dart';

import 'error.dart';

abstract class UseCase<T, Params> {
  const UseCase();

  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}

class SearchParams {
  final int userId;
  final String date;

  const SearchParams({required this.userId, required this.date});
}

class AddParams<T> {
  final int userId;
  final T data;

  const AddParams({required this.userId, required this.data});
}

class UpdateParams<T> {
  final int userId;
  final int dataId;
  final T data;

  const UpdateParams({
    required this.userId,
    required this.dataId,
    required this.data,
  });
}
