import 'package:json_annotation/json_annotation.dart';

part 'captcha_image_bean.g.dart';

@JsonSerializable()
class CaptchaImageBean extends Object {
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'captcha_image_key')
  String captchaImageKey;

  @JsonKey(name: 'expired_at')
  String expiredAt;

  @JsonKey(name: 'captcha_image_content')
  String captchaImageContent;

  @JsonKey(name: 'captcha_image_code')
  String captchaImageCode;

  CaptchaImageBean(
    this.captchaImageKey,
    this.expiredAt,
    this.captchaImageContent,
    this.captchaImageCode,
    this.message,
  );

  factory CaptchaImageBean.fromJson(Map<String, dynamic> srcJson) =>
      _$CaptchaImageBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CaptchaImageBeanToJson(this);
}
