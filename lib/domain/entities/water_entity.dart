import 'package:equatable/equatable.dart';

class WaterEntity extends Equatable {
  final int usersId;
  final String date;
  final int target;
  final int total;

  const WaterEntity({
    required this.usersId,
    required this.date,
    required this.target,
    required this.total,
  });

  @override
  List<Object?> get props => [
        usersId,
        date,
        target,
        total,
      ];
}
