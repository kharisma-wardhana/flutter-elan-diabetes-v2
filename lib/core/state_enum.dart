import 'package:equatable/equatable.dart';

import 'error.dart';

enum ViewState { initial, loading, hasData, noData, error }

extension ViewStateExtension on ViewState {
  bool get isInitial => this == ViewState.initial;

  bool get isLoading => this == ViewState.loading;

  bool get isHasData => this == ViewState.hasData;

  bool get isNoData => this == ViewState.noData;

  bool get isError => this == ViewState.error;
}

class ViewData<T> extends Equatable {
  final ViewState status;
  final T? data;
  final String message;
  final Failure? failure;

  const ViewData._({
    required this.status,
    this.data,
    this.message = '',
    this.failure,
  });

  factory ViewData.loaded({T? data}) {
    return ViewData._(status: ViewState.hasData, data: data);
  }

  factory ViewData.error({required String message, required Failure? failure}) {
    return ViewData._(
      status: ViewState.error,
      message: message,
      failure: failure,
    );
  }

  factory ViewData.loading({String? message}) {
    return ViewData._(status: ViewState.loading, message: message ?? '');
  }

  factory ViewData.initial() {
    return const ViewData._(status: ViewState.initial);
  }

  factory ViewData.noData({required String message}) {
    return ViewData._(status: ViewState.noData, message: message);
  }

  @override
  List<Object?> get props => [status, data, message, failure];
}
