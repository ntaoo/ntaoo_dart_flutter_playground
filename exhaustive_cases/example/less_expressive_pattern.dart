import 'package:meta/meta.dart';

enum NetworkResponseType { success, error }

@sealed
@immutable
class NetworkResponse {
  final NetworkResponseType type;
  final int statusCode;
  final Map<String, dynamic> body;

  const NetworkResponse._(this.type, this.body, this.statusCode);

  factory NetworkResponse.success(Map<String, dynamic> body, int statusCode) =>
      NetworkResponse._(NetworkResponseType.success, body, statusCode);
  factory NetworkResponse.error(Map<String, dynamic> body, int statusCode) =>
      NetworkResponse._(NetworkResponseType.error, body, statusCode);
}

void handleResponse(NetworkResponse response) {
  switch (response.type) {
    case NetworkResponseType.success:
      print(response.body);
      break;
    case NetworkResponseType.error:
      print(response.body);
      break;
  }
}

void main() {
  final response = NetworkResponse.success({'a': 'b'}, 200);
  handleResponse(response);
}
