import 'package:elan/domain/entities/ginjal_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';

class GinjalState extends Equatable {
  final ViewData<List<GinjalEntity>> ginjalState;

  const GinjalState({required this.ginjalState});

  @override
  List<Object?> get props => [ginjalState];
}
