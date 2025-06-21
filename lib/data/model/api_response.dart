class ApiResponse<T> {
  final T? data;

  const ApiResponse({this.data});
}

class Meta {
  final int code;
  final String status;
  final String? message;

  Meta({required this.code, required this.status, this.message});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      code: json['code'],
      status: json['status'],
      message: json['message'],
    );
  }
}
