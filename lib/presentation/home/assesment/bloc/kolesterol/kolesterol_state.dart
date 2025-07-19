import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/kolesterol_entity.dart';

class KolesterolState extends Equatable {
  final ViewData<List<KolesterolEntity>> kolesterolState;

  const KolesterolState({required this.kolesterolState});

  @override
  List<Object?> get props => [kolesterolState];
}
