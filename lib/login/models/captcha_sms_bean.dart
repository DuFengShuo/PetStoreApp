import 'package:json_annotation/json_annotation.dart';

part 'captcha_sms_bean.g.dart';

@JsonSerializable()
class CaptchaSmsBean extends Object {
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'captcha_sms_key')
  String captchaSmsKey;

  @JsonKey(name: 'expired_at')
  String expiredAt;

  @JsonKey(name: 'captcha_sms_code')
  String captchaSmsCode;

  CaptchaSmsBean(
    this.captchaSmsKey,
    this.expiredAt,
    this.captchaSmsCode,
    this.message,
  );

  factory CaptchaSmsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$CaptchaSmsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CaptchaSmsBeanToJson(this);
}
