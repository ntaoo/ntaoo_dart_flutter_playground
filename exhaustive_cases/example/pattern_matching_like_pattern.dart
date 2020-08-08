// ignore: avoid_relative_lib_imports
import '../lib/pattern_matching_like_pattern.dart';

void main() {
  final response = NetworkResponse.success({'a': 'b'}, 200);
  handleResponse(response);
}
