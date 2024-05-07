import 'package:json_annotation/json_annotation.dart';
import 'package:pure_extensions/pure_extensions.dart';

part 'open_api.g.dart';

mixin PrettyJsonToString {
  Map<String, dynamic> toJson();
  @override
  String toString() => '${toJson()}';
}

@JsonSerializable()
class OpenApi with PrettyJsonToString {
  /// Endpoint path
  final Map<String, PathOpenApi> paths;
  final ComponentsOpenApi components;

  const OpenApi({
    required this.paths,
    required this.components,
  });

  factory OpenApi.fromJson(Map<String, dynamic> map) => _$OpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$OpenApiToJson(this);
}

@JsonSerializable()
class PathOpenApi with PrettyJsonToString {
  final MethodOpenApi? get;
  final MethodOpenApi? post;
  final MethodOpenApi? put;

  const PathOpenApi({
    this.get,
    this.post,
    this.put,
  });

  Map<String, MethodOpenApi> get methods =>
      (<String, MethodOpenApi?>{'get': get, 'post': post, 'put': put}).whereNotNull();

  factory PathOpenApi.fromJson(Map<String, dynamic> map) => _$PathOpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$PathOpenApiToJson(this);
}

@JsonSerializable()
class MethodOpenApi with PrettyJsonToString {
  final String summary;
  final String description;
  final String operationId;
  final List<ParameterOpenApi> parameters;
  final RequestBodyOpenApi? requestBody;
  final Map<String, ResponseOpenApi> responses;

  const MethodOpenApi({
    required this.summary,
    required this.description,
    required this.operationId,
    this.parameters = const [],
    required this.requestBody,
    required this.responses,
  });

  ResponseOpenApi? get successResponse => responses['200'];

  factory MethodOpenApi.fromJson(Map<String, dynamic> map) => _$MethodOpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$MethodOpenApiToJson(this);
}

@JsonEnum()
enum ParameterInOpenApi { path, query, body, header, formData }

@JsonSerializable()
class ParameterOpenApi with PrettyJsonToString {
  final String name;
  @JsonKey(name: 'in')
  final ParameterInOpenApi in$;
  final bool required;
  final String? description;
  final SchemaOpenApi? schema; // Property

  const ParameterOpenApi({
    required this.name,
    required this.in$,
    this.required = false,
    required this.description,
    required this.schema,
  });

  factory ParameterOpenApi.fromJson(Map<String, dynamic> map) => _$ParameterOpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$ParameterOpenApiToJson(this);
}

@JsonSerializable()
class RequestBodyOpenApi with PrettyJsonToString {
  final bool required;
  final ContentOpenApi content;

  const RequestBodyOpenApi({
    this.required = false,
    required this.content,
  });

  factory RequestBodyOpenApi.fromJson(Map<String, dynamic> map) =>
      _$RequestBodyOpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$RequestBodyOpenApiToJson(this);
}

@JsonSerializable()
class ContentOpenApi with PrettyJsonToString {
  @JsonKey(name: 'application/json')
  final JsonContentOpenApi? json;

  const ContentOpenApi({
    this.json,
  });

  factory ContentOpenApi.fromJson(Map<String, dynamic> map) => _$ContentOpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$ContentOpenApiToJson(this);
}

@JsonSerializable()
class JsonContentOpenApi with PrettyJsonToString {
  final SchemaOpenApi schema;

  const JsonContentOpenApi({
    required this.schema,
  });

  factory JsonContentOpenApi.fromJson(Map<String, dynamic> map) =>
      _$JsonContentOpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$JsonContentOpenApiToJson(this);
}

@JsonSerializable()
class ResponseOpenApi with PrettyJsonToString {
  final String description;
  final SchemaOpenApi? schema;

  const ResponseOpenApi({
    required this.description,
    required this.schema,
  });

  factory ResponseOpenApi.fromJson(Map<String, dynamic> map) => _$ResponseOpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$ResponseOpenApiToJson(this);
}

@JsonSerializable()
class ComponentsOpenApi with PrettyJsonToString {
  final List<String> required;
  final Map<String, SchemaOpenApi> schemas;

  const ComponentsOpenApi({
    this.required = const [],
    required this.schemas,
  });

  factory ComponentsOpenApi.fromJson(Map<String, dynamic> map) => _$ComponentsOpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$ComponentsOpenApiToJson(this);
}

@JsonEnum()
enum TypeOpenApi {
  boolean,
  number,
  integer,
  string,
  array,
  object,
}

@JsonEnum()
enum FormatOpenApi {
  int64,
  int32,
  double,
  @JsonValue('date-time')
  dateTime,
}

@JsonSerializable()
class SchemaOpenApi with PrettyJsonToString {
  /// Is null when [ref] exist
  final TypeOpenApi? type;

  final FormatOpenApi? format;

  /// With [TypeOpenApi.integer] | [TypeOpenApi.string]
  final List<String>? enum$;

  /// With [TypeOpenApi.array]
  final SchemaOpenApi? items;

  @JsonKey(name: '\$ref')
  final String? ref; // "$ref": "#/definitions/Category"

  /// With [TypeOpenApi.object]
  final Map<String, SchemaOpenApi>? properties;

  /// With [TypeOpenApi.object]
  final List<String>? required;

  final String? description;
  final Object? example;

  const SchemaOpenApi({
    this.type,
    this.format,
    this.enum$,
    this.items,
    this.ref,
    this.properties,
    this.required,
    this.description,
    this.example,
  });

  factory SchemaOpenApi.fromJson(Map<String, dynamic> map) => _$SchemaOpenApiFromJson(map);
  Map<String, dynamic> toJson() => _$SchemaOpenApiToJson(this);
}
