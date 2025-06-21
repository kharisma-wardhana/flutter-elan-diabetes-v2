import 'package:equatable/equatable.dart';

class ServerException implements Exception {
  final int? statusCode;
  final String message;

  ServerException({this.statusCode, required this.message});
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}
