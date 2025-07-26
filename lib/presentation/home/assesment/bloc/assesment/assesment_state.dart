import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/assesment/assesment_entity.dart';

class AssesmentState extends Equatable {
  final ViewData<AssesmentEntity> assesmentState;

  const AssesmentState({required this.assesmentState});

  @override
  List<Object?> get props => [assesmentState];
}
