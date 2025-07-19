import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/gula_darah/gula_darah.dart';

class GulaState extends Equatable {
  final ViewData<List<GulaDarahEntity>> gulaState;

  const GulaState({required this.gulaState});

  @override
  List<Object?> get props => [gulaState];
}
