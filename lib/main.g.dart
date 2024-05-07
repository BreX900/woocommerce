// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schema _$SchemaFromJson(Map<String, dynamic> json) => Schema(
      namespace: json['namespace'] as String,
      routes: (json['routes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, RouteSchema.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$SchemaToJson(Schema instance) => <String, dynamic>{
      'namespace': instance.namespace,
      'routes': instance.routes.map((k, e) => MapEntry(k, e.toJson())),
    };

RouteSchema _$RouteSchemaFromJson(Map<String, dynamic> json) => RouteSchema(
      methods: (json['methods'] as List<dynamic>)
          .map((e) => $enumDecode(_$MethodSchemaEnumMap, e))
          .toList(),
      endpoints: (json['endpoints'] as List<dynamic>)
          .map((e) => EndPointSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RouteSchemaToJson(RouteSchema instance) =>
    <String, dynamic>{
      'methods': instance.methods.map((e) => _$MethodSchemaEnumMap[e]).toList(),
      'endpoints': instance.endpoints.map((e) => e.toJson()).toList(),
    };

const _$MethodSchemaEnumMap = {
  MethodSchema.get: 'GET',
  MethodSchema.post: 'POST',
  MethodSchema.delete: 'DELETE',
  MethodSchema.put: 'PUT',
  MethodSchema.patch: 'PATCH',
};

EndPointSchema _$EndPointSchemaFromJson(Map<String, dynamic> json) =>
    EndPointSchema(
      methods: (json['methods'] as List<dynamic>)
          .map((e) => $enumDecode(_$MethodSchemaEnumMap, e))
          .toList(),
      args: (json['args'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ArgSchema.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$EndPointSchemaToJson(EndPointSchema instance) =>
    <String, dynamic>{
      'methods': instance.methods.map((e) => _$MethodSchemaEnumMap[e]).toList(),
      'args': instance.args.map((k, e) => MapEntry(k, e.toJson())),
    };

ArgSchema _$ArgSchemaFromJson(Map<String, dynamic> json) => ArgSchema(
      description: json['description'] as String?,
      type: $enumDecodeNullable(_$TypeSchemaEnumMap, json['type']),
      required: json['required'] as bool,
    );

Map<String, dynamic> _$ArgSchemaToJson(ArgSchema instance) => <String, dynamic>{
      'description': instance.description,
      'type': _$TypeSchemaEnumMap[instance.type],
      'required': instance.required,
    };

const _$TypeSchemaEnumMap = {
  TypeSchema.boolean: 'boolean',
  TypeSchema.integer: 'integer',
  TypeSchema.string: 'string',
  TypeSchema.array: 'array',
  TypeSchema.date: 'date',
  TypeSchema.url: 'url',
  TypeSchema.object: 'object',
};
