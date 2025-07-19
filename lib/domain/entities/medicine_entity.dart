import 'package:equatable/equatable.dart';

class MedicineEntity extends Equatable {
  final int? id;
  final String date;
  final String name;
  final int? duration;
  final String dosis;
  final int type;
  final int? status;

  const MedicineEntity({
    this.id,
    required this.date,
    required this.name,
    this.duration,
    required this.dosis,
    required this.type,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        name,
        duration,
        dosis,
        type,
        status,
      ];
}
