import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pure_extensions/pure_extensions.dart';

part 'main.g.dart';

void main() async {
  final dio = Dio();

  final resp = await dio.get('https://www.alexsagrato.com/wp-json/wc/store');

  // print(resp.data);
  print('=======================================================');
  final schema = Schema.fromJson(resp.data);
  print(schema);

  final api = Class((b) => b
    ..name = 'StoreApi'
    ..methods.replace(schema.routes.generateIterable((path, route) {
      return Method((b) => b
        ..name =
            '${path.replaceAll(RegExp(r'(\(\?.*\))'), 'regexp').replaceAll('/', '_').camelCase}');
    })));

  final emitter = DartEmitter();
  print(DartFormatter().format('${api.accept(emitter)}'));
}

@JsonSerializable()
class Schema {
  final String namespace;

  /// Path
  final Map<String, RouteSchema> routes;

  const Schema({
    required this.namespace,
    required this.routes,
  });

  factory Schema.fromJson(Map<String, dynamic> map) => _$SchemaFromJson(map);
  Map<String, dynamic> toJson() => _$SchemaToJson(this);

  @override
  String toString() => '${toJson()}';
}

@JsonSerializable()
class RouteSchema {
  final List<MethodSchema> methods;

  final List<EndPointSchema> endpoints;

  const RouteSchema({
    required this.methods,
    required this.endpoints,
  });

  factory RouteSchema.fromJson(Map<String, dynamic> map) => _$RouteSchemaFromJson(map);
  Map<String, dynamic> toJson() => _$RouteSchemaToJson(this);

  @override
  String toString() => '${toJson()}';
}

@JsonSerializable()
class EndPointSchema {
  final List<MethodSchema> methods;

  /// ArgName
  final Map<String, ArgSchema> args;

  const EndPointSchema({
    required this.methods,
    required this.args,
  });

  factory EndPointSchema.fromJson(Map<String, dynamic> map) {
    final args = map['args'];
    if (args is List && args.isEmpty) {
      map = {
        ...map,
        'args': const <String, dynamic>{},
      };
    }
    return _$EndPointSchemaFromJson(map);
  }
  Map<String, dynamic> toJson() => _$EndPointSchemaToJson(this);

  @override
  String toString() => '${toJson()}';
}

@JsonSerializable()
class ArgSchema {
  final String? description;
  final TypeSchema? type;
  final bool required;

  const ArgSchema({
    required this.description,
    required this.type,
    required this.required,
  });

  factory ArgSchema.fromJson(Map<String, dynamic> map) {
    final type = map['type'];
    if (type is List) {
      print('More types $type\n${StackTrace.current}');
      map = {
        ...map,
        'type': type.first,
      };
    }
    return _$ArgSchemaFromJson(map);
  }
  Map<String, dynamic> toJson() => _$ArgSchemaToJson(this);

  @override
  String toString() => '${toJson()}';
}

@JsonEnum()
enum MethodSchema {
  @JsonValue('GET')
  get,
  @JsonValue('POST')
  post,
  @JsonValue('DELETE')
  delete,
  @JsonValue('PUT')
  put,
  @JsonValue('PATCH')
  patch,
}

@JsonEnum()
enum TypeSchema {
  boolean,
  integer,
  string,
  array,
  date,
  url,
  object,
}
