import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/antropometri_entity.dart';

class AntropometriState extends Equatable {
  final ViewData<AntropometriEntity> antropometriState;

  const AntropometriState({required this.antropometriState});

  @override
  List<Object?> get props => [antropometriState];
}
