import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final int id;
  final String name;
  final String position;
  final String mobile;
  final String image;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.position,
    required this.mobile,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        position,
        mobile,
        image,
      ];
}
