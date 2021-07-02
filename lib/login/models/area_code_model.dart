import 'package:json_annotation/json_annotation.dart';

part 'area_code_model.g.dart';

@JsonSerializable()
class AreaCodeModel extends Object {
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'name_en')
  String nameEn;

  @JsonKey(name: 'name_zh')
  String nameZh;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'locale')
  String locale;

  @JsonKey(name: 'preg')
  String preg;

  AreaCodeModel(
    this.nameEn,
    this.nameZh,
    this.code,
    this.locale,
    this.preg,
    this.message,
  );

  factory AreaCodeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AreaCodeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AreaCodeModelToJson(this);
}
