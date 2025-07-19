import 'package:dartz/dartz.dart';

import 'error.dart';

abstract class UseCase<T, Params> {
  const UseCase();

  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}

class SearchParams {
  final String date;

  const SearchParams({required this.date});
}

class AddParams<T> {
  final T data;

  const AddParams({required this.data});
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
