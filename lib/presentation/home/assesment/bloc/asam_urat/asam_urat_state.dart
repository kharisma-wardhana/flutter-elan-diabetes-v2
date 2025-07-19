import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/asam_urat_entity.dart';

class AsamUratState extends Equatable {
  final ViewData<List<AsamUratEntity>> asamUratState;

  const AsamUratState({required this.asamUratState});

  @override
  List<Object?> get props => [asamUratState];
}
