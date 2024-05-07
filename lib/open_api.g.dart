// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenApi _$OpenApiFromJson(Map<String, dynamic> json) => OpenApi(
      paths: (json['paths'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, PathOpenApi.fromJson(e as Map<String, dynamic>)),
      ),
      components: ComponentsOpenApi.fromJson(
          json['components'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpenApiToJson(OpenApi instance) => <String, dynamic>{
      'paths': instance.paths.map((k, e) => MapEntry(k, e.toJson())),
      'components': instance.components.toJson(),
    };

PathOpenApi _$PathOpenApiFromJson(Map<String, dynamic> json) => PathOpenApi(
      get: json['get'] == null
          ? null
          : MethodOpenApi.fromJson(json['get'] as Map<String, dynamic>),
      post: json['post'] == null
          ? null
          : MethodOpenApi.fromJson(json['post'] as Map<String, dynamic>),
      put: json['put'] == null
          ? null
          : MethodOpenApi.fromJson(json['put'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PathOpenApiToJson(PathOpenApi instance) =>
    <String, dynamic>{
      'get': instance.get?.toJson(),
      'post': instance.post?.toJson(),
      'put': instance.put?.toJson(),
    };

MethodOpenApi _$MethodOpenApiFromJson(Map<String, dynamic> json) =>
    MethodOpenApi(
      summary: json['summary'] as String,
      description: json['description'] as String,
      operationId: json['operationId'] as String,
      parameters: (json['parameters'] as List<dynamic>?)
              ?.map((e) => ParameterOpenApi.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      requestBody: json['requestBody'] == null
          ? null
          : RequestBodyOpenApi.fromJson(
              json['requestBody'] as Map<String, dynamic>),
      responses: (json['responses'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, ResponseOpenApi.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$MethodOpenApiToJson(MethodOpenApi instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'description': instance.description,
      'operationId': instance.operationId,
      'parameters': instance.parameters.map((e) => e.toJson()).toList(),
      'requestBody': instance.requestBody?.toJson(),
      'responses': instance.responses.map((k, e) => MapEntry(k, e.toJson())),
    };

ParameterOpenApi _$ParameterOpenApiFromJson(Map<String, dynamic> json) =>
    ParameterOpenApi(
      name: json['name'] as String,
      in$: $enumDecode(_$ParameterInOpenApiEnumMap, json['in']),
      required: json['required'] as bool? ?? false,
      description: json['description'] as String?,
      schema: json['schema'] == null
          ? null
          : SchemaOpenApi.fromJson(json['schema'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParameterOpenApiToJson(ParameterOpenApi instance) =>
    <String, dynamic>{
      'name': instance.name,
      'in': _$ParameterInOpenApiEnumMap[instance.in$],
      'required': instance.required,
      'description': instance.description,
      'schema': instance.schema?.toJson(),
    };

const _$ParameterInOpenApiEnumMap = {
  ParameterInOpenApi.path: 'path',
  ParameterInOpenApi.query: 'query',
  ParameterInOpenApi.body: 'body',
  ParameterInOpenApi.header: 'header',
  ParameterInOpenApi.formData: 'formData',
};

RequestBodyOpenApi _$RequestBodyOpenApiFromJson(Map<String, dynamic> json) =>
    RequestBodyOpenApi(
      required: json['required'] as bool? ?? false,
      content: ContentOpenApi.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestBodyOpenApiToJson(RequestBodyOpenApi instance) =>
    <String, dynamic>{
      'required': instance.required,
      'content': instance.content.toJson(),
    };

ContentOpenApi _$ContentOpenApiFromJson(Map<String, dynamic> json) =>
    ContentOpenApi(
      json: json['application/json'] == null
          ? null
          : JsonContentOpenApi.fromJson(
              json['application/json'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentOpenApiToJson(ContentOpenApi instance) =>
    <String, dynamic>{
      'application/json': instance.json?.toJson(),
    };

JsonContentOpenApi _$JsonContentOpenApiFromJson(Map<String, dynamic> json) =>
    JsonContentOpenApi(
      schema: SchemaOpenApi.fromJson(json['schema'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonContentOpenApiToJson(JsonContentOpenApi instance) =>
    <String, dynamic>{
      'schema': instance.schema.toJson(),
    };

ResponseOpenApi _$ResponseOpenApiFromJson(Map<String, dynamic> json) =>
    ResponseOpenApi(
      description: json['description'] as String,
      schema: json['schema'] == null
          ? null
          : SchemaOpenApi.fromJson(json['schema'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseOpenApiToJson(ResponseOpenApi instance) =>
    <String, dynamic>{
      'description': instance.description,
      'schema': instance.schema?.toJson(),
    };

ComponentsOpenApi _$ComponentsOpenApiFromJson(Map<String, dynamic> json) =>
    ComponentsOpenApi(
      required: (json['required'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      schemas: (json['schemas'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, SchemaOpenApi.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ComponentsOpenApiToJson(ComponentsOpenApi instance) =>
    <String, dynamic>{
      'required': instance.required,
      'schemas': instance.schemas.map((k, e) => MapEntry(k, e.toJson())),
    };

SchemaOpenApi _$SchemaOpenApiFromJson(Map<String, dynamic> json) =>
    SchemaOpenApi(
      type: $enumDecodeNullable(_$TypeOpenApiEnumMap, json['type']),
      format: $enumDecodeNullable(_$FormatOpenApiEnumMap, json['format']),
      enum$:
          (json[r'enum$'] as List<dynamic>?)?.map((e) => e as String).toList(),
      items: json['items'] == null
          ? null
          : SchemaOpenApi.fromJson(json['items'] as Map<String, dynamic>),
      ref: json[r'$ref'] as String?,
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, SchemaOpenApi.fromJson(e as Map<String, dynamic>)),
      ),
      required: (json['required'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      example: json['example'],
    );

Map<String, dynamic> _$SchemaOpenApiToJson(SchemaOpenApi instance) =>
    <String, dynamic>{
      'type': _$TypeOpenApiEnumMap[instance.type],
      'format': _$FormatOpenApiEnumMap[instance.format],
      r'enum$': instance.enum$,
      'items': instance.items?.toJson(),
      r'$ref': instance.ref,
      'properties': instance.properties?.map((k, e) => MapEntry(k, e.toJson())),
      'required': instance.required,
      'description': instance.description,
      'example': instance.example,
    };

const _$TypeOpenApiEnumMap = {
  TypeOpenApi.boolean: 'boolean',
  TypeOpenApi.number: 'number',
  TypeOpenApi.integer: 'integer',
  TypeOpenApi.string: 'string',
  TypeOpenApi.array: 'array',
  TypeOpenApi.object: 'object',
};

const _$FormatOpenApiEnumMap = {
  FormatOpenApi.int64: 'int64',
  FormatOpenApi.int32: 'int32',
  FormatOpenApi.double: 'double',
  FormatOpenApi.dateTime: 'date-time',
};
