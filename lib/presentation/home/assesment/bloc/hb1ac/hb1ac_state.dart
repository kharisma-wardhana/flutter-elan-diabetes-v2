import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/hb1ac_entity.dart';

class Hb1acState extends Equatable {
  final ViewData<List<Hb1acEntity>> hbState;

  const Hb1acState({required this.hbState});

  @override
  List<Object?> get props => [hbState];
}
