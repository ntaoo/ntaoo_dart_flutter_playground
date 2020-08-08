import 'dart:mirrors';

import 'package:recase/recase.dart';
import 'package:test/test.dart';
import 'package:exhaustive_cases/pattern_matching_like_pattern.dart'
    hide NetworkResponse;

// Because in Dart 2 there is a mirror system bug on redirect factory constructor,
// using Normal static method instead is necessary for testing with dart:mirrors.
// https://github.com/dart-lang/sdk/issues/33041#issuecomment-390096556
// https://github.com/dart-lang/sdk/issues/41915
abstract class NetworkResponse {
  NetworkResponseType get type;
  int get statusCode;
  Map<String, dynamic> get body;
  static Success success(Map<String, dynamic> body, int statusCode) =>
      Success(body, statusCode);
  static Error error(Map<String, dynamic> body, int statusCode,
          String someAdditionalInfoForError) =>
      Error(body, statusCode, someAdditionalInfoForError);
}

void main() {
  group(NetworkResponse, () {
    test(
        '$NetworkResponse has exhaustive factory method-like static methods'
        'which names are corresponding to $NetworkResponseType values.'
        'and its returnType string is a Pascal case of the name', () {
      final classMirror = reflectClass(NetworkResponse);

      for (final v in NetworkResponseType.values) {
        final name = v.toString().split('.').last;
        final methodMirror = classMirror.staticMembers[Symbol(name)];
        expect(methodMirror.simpleName, Symbol(name));
        expect(methodMirror.returnType.simpleName,
            Symbol(ReCase(name).pascalCase));
      }
    });
  });

  test('$Success instance has corresponding $NetworkResponseType', () {
    final instance = Success({}, 200);
    expect(instance.runtimeType.toString(),
        ReCase(instance.type.toString().split('.').last).pascalCase);
  });

  test('$Error instance has corresponding $NetworkResponseType', () {
    final instance = Error({}, 400, '');
    expect(instance.runtimeType.toString(),
        ReCase(instance.type.toString().split('.').last).pascalCase);
  });
}
