// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) {
  return BaseModel(
    json['message'] as String,
    json['status_code'] as int,
    json['debug'] == null
        ? null
        : Debug.fromJson(json['debug'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'message': instance.message,
      'status_code': instance.statusCode,
      'debug': instance.debug,
    };

Debug _$DebugFromJson(Map<String, dynamic> json) {
  return Debug();
}

Map<String, dynamic> _$DebugToJson(Debug instance) => <String, dynamic>{};
