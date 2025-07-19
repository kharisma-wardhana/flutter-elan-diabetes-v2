import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/water_entity.dart';

class WaterState extends Equatable {
  final ViewData<List<WaterEntity>> waterState;

  const WaterState({required this.waterState});

  @override
  List<Object?> get props => [waterState];
}
