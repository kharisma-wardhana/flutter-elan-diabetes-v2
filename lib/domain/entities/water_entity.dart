import 'package:equatable/equatable.dart';

class WaterEntity extends Equatable {
  final String date;
  final int target;
  final int total;

  const WaterEntity({
    required this.date,
    required this.target,
    required this.total,
  });

  @override
  List<Object?> get props => [date, target, total];
}
