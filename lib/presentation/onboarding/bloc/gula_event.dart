import 'package:freezed_annotation/freezed_annotation.dart';

part 'gula_event.freezed.dart';

@freezed
abstract class GulaEvent with _$GulaEvent {
  const factory GulaEvent.addGulaDarahPuasa({required String gulaDarahPuasa}) =
      AddGulaDarahPuasaEvent;

  const factory GulaEvent.addGulaDarahSewaktu({
    required String gulaDarahSewaktu,
  }) = AddGulaDarahSewaktuEvent;

  const factory GulaEvent.getGulaDarah() = GetGulaDarahEvent;

  const factory GulaEvent.checkGulaDarahPuasa({
    required String gulaDarahPuasa,
  }) = CheckGulaDarahPuasaEvent;

  const factory GulaEvent.checkGulaDarahSewaktu({
    required String gulaDarahSewaktu,
  }) = CheckGulaDarahSewaktuEvent;
}
