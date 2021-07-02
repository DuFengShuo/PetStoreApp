import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel extends Object {
  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'status_code')
  int statusCode;

  @JsonKey(name: 'debug')
  Debug debug;

  BaseModel(
    this.message,
    this.statusCode,
    this.debug,
  );

  factory BaseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BaseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}

@JsonSerializable()
class Debug extends Object {
  Debug();

  factory Debug.fromJson(Map<String, dynamic> srcJson) =>
      _$DebugFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DebugToJson(this);
}
