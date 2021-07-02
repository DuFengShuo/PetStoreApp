// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha_sms_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptchaSmsBean _$CaptchaSmsBeanFromJson(Map<String, dynamic> json) {
  return CaptchaSmsBean(
    json['captcha_sms_key'] as String,
    json['expired_at'] as String,
    json['captcha_sms_code'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$CaptchaSmsBeanToJson(CaptchaSmsBean instance) =>
    <String, dynamic>{
      'message': instance.message,
      'captcha_sms_key': instance.captchaSmsKey,
      'expired_at': instance.expiredAt,
      'captcha_sms_code': instance.captchaSmsCode,
    };
