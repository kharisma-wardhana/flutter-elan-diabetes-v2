import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/doctor_entity.dart';

class DoctorState extends Equatable {
  final ViewData<List<DoctorEntity>> doctorState;

  const DoctorState({required this.doctorState});

  @override
  List<Object?> get props => [doctorState];
}
