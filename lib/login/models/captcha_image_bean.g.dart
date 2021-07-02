// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha_image_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptchaImageBean _$CaptchaImageBeanFromJson(Map<String, dynamic> json) {
  return CaptchaImageBean(
    json['captcha_image_key'] as String,
    json['expired_at'] as String,
    json['captcha_image_content'] as String,
    json['captcha_image_code'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$CaptchaImageBeanToJson(CaptchaImageBean instance) =>
    <String, dynamic>{
      'message': instance.message,
      'captcha_image_key': instance.captchaImageKey,
      'expired_at': instance.expiredAt,
      'captcha_image_content': instance.captchaImageContent,
      'captcha_image_code': instance.captchaImageCode,
    };
