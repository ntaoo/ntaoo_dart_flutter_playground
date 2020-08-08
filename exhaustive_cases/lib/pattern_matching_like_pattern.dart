import 'package:meta/meta.dart';

enum NetworkResponseType { success, error }

@sealed
abstract class NetworkResponse {
  NetworkResponseType get type;
  int get statusCode;
  Map<String, dynamic> get body;
  factory NetworkResponse.success(Map<String, dynamic> body, int statusCode) =
      Success;
  factory NetworkResponse.error(Map<String, dynamic> body, int statusCode,
      String someAdditionalInfoForError) = Error;
}

@sealed
class Success implements NetworkResponse {
  @override
  final NetworkResponseType type = NetworkResponseType.success;
  @override
  final int statusCode;
  @override
  final Map<String, dynamic> body;
  const Success(this.body, this.statusCode) : assert(statusCode < 400);
}

@sealed
class Error implements NetworkResponse {
  @override
  final NetworkResponseType type = NetworkResponseType.error;
  @override
  final int statusCode;
  @override
  final Map<String, dynamic> body;
  final String someAdditionalInfoForError;
  const Error(this.body, this.statusCode, this.someAdditionalInfoForError)
      : assert(statusCode >= 400);
}

void handleResponse(NetworkResponse response) {
  switch (response.type) {
    case NetworkResponseType.success:
      final success = response as Success;
      print(success.runtimeType);
      print(success.body);
      break;
    case NetworkResponseType.error:
      final error = response as Error;
      print(error.runtimeType);
      print(error.body);
      print(error.someAdditionalInfoForError);
      break;
  }
}
