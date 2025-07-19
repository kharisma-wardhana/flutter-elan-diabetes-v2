import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/tensi_entity.dart';

class TensiState extends Equatable {
  final ViewData<List<TensiEntity>> tensiState;

  const TensiState({required this.tensiState});

  @override
  List<Object?> get props => [tensiState];
}
