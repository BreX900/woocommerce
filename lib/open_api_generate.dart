import 'dart:convert';
import 'dart:io';

import 'package:built_value/built_value.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:pure_extensions/pure_extensions.dart';
import 'package:woocommerce/open_api.dart';

String build(String method, String path) {
  return '''
  return await _client.request('$method', '$path');
  ''';
}

Future<Map<String, dynamic>> readOpenApi({String? path, String? url}) async {
  if (path != null) {
    final file = File(path);
    final rawOpenApi = file.readAsStringSync();
    return jsonDecode(rawOpenApi);
  } else if (url != null) {
    final response = await get(Uri.parse(url));
    final rawOpenApi = response.body;
    return jsonDecode(rawOpenApi);
  }
  throw StateError('path != null || url != null');
}

void main() async {
  final rawOpenApi = await readOpenApi(
    // url: 'https://api.develop.toonie.portit.io/offers/swagger/v3/api-docs',
    path: 'lib/open_api.json',
  );
  final openApi = OpenApi.fromJson(rawOpenApi);

  // print(openApi);

  final api = Class((b) => b
    ..name = 'Api'
    ..fields.add(Field((b) => b
      ..modifier = FieldModifier.final$
      ..type = const Reference('ApiClient')
      ..name = '_client'))
    ..methods.replace(openApi.paths.generateIterable((path, route) {
      return route.methods.generateIterable((name, method) {
        final responseSchema = method.successResponse?.schema;
        return Method((b) => b
          ..docs.add('/// ${method.summary}')
          ..docs.add('///')
          ..docs.add('/// ${method.description}')
          ..returns = TypeReference((b) => b
            ..symbol = 'Future'
            ..types.add(responseSchema == null
                ? const Reference('void')
                : _mapPropertyToMethodType(responseSchema)))
          ..name = method.operationId
          ..modifier = MethodModifier.async
          ..body = Code(build(name.toUpperCase(), path)));
      });
    }).expand((element) => element)));

  final dtos = openApi.components.schemas.generateIterable((name, schema) {
    return Class((b) => b
      ..name = name
      ..fields.addAll(schema.properties!.generateIterable((name, property) => Field((b) => b
        ..when(property.description != null, () => b.docs.add('/// ${property.description}'))
        ..when(
            property.example != null, () => b.docs.add('/// Ex: ${jsonEncode(property.example)}'))
        ..modifier = FieldModifier.final$
        ..name = name
        ..type = _mapPropertyToMethodType(property))))
      ..constructors.add(Constructor((b) => b
        ..constant = true
        ..optionalParameters.addAll(schema.properties!.generateIterable((name, property) {
          return Parameter((b) => b
            ..named = true
            ..required = schema.required?.contains(name) ?? true
            ..toThis = true
            ..name = name);
        })))));
  });

  final library = Library((b) => b
    ..body.add(api)
    ..body.addAll(dtos));

  final emitter = DartEmitter();
  print(DartFormatter().format('${library.accept(emitter)}'));
}

Reference _mapPropertyToMethodType(SchemaOpenApi property) {
  switch (property.format) {
    case FormatOpenApi.int32:
    case FormatOpenApi.int64:
      return const Reference('int');
    case FormatOpenApi.double:
      return const Reference('double');
    case FormatOpenApi.dateTime:
      return const Reference('DateTime');
    case null:
      break;
  }

  switch (property.type) {
    case TypeOpenApi.boolean:
      return const Reference('bool');
    case TypeOpenApi.integer:
      return const Reference('int');
    case TypeOpenApi.number:
      return const Reference('num');
    case TypeOpenApi.string:
      return const Reference('String');
    case TypeOpenApi.array:
      if (property.items == null) throw property;
      return TypeReference((b) => b
        ..symbol = 'List'
        ..types.add(_mapPropertyToMethodType(property.items!)));
    case TypeOpenApi.object:
      return const Reference('dynamic');
    case null:
      if (property.ref == null) return const Reference('void');

      return Reference(property.ref!.split('/').last);
  }
}

abstract class ApiClient {
  Future<T> request<T>(String method, String path, {Map<String, dynamic>? data});
}

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient(this._dio);

  @override
  Future<T> request<T>(String method, String path, {Map<String, dynamic>? data}) async {
    final response = await _dio.request(path, data: data, options: Options(method: method));
    return response.data;
  }
}

extension on Builder {
  void when(bool predicate, void Function() fn) => predicate ? fn() : null;
}
