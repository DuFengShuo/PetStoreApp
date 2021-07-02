import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel extends Object {
  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'status')
  int status; //0成功 1失败

  StatusModel(
    this.message,
    this.status,
  );

  factory StatusModel.fromJson(Map<String, dynamic> srcJson) =>
      _$StatusModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
