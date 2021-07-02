// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBean _$UserBeanFromJson(Map<String, dynamic> json) {
  return UserBean(
    json['id'] as String,
    json['name'] as String,
    json['email'] as String,
    json['mobile'] as String,
    json['avatar'] as String,
    json['company_name'] as String,
    json['company_lnfo'] as String,
    json['company_address'] as String,
    json['revenue'] as String,
    json['legal_represetive'] as String,
    json['created_at'] as int,
    json['updated_at'] as int,
    json['favorite_count'] as int,
    json['browsing_count'] as int,
    json['register_time'] as String,
    json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String,
  );
}

Map<String, dynamic> _$UserBeanToJson(UserBean instance) => <String, dynamic>{
      'message': instance.message,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'avatar': instance.avatar,
      'company_name': instance.companyName,
      'company_lnfo': instance.companyLnfo,
      'company_address': instance.companyAddress,
      'revenue': instance.revenue,
      'legal_represetive': instance.legalRepresetive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'favorite_count': instance.favoriteCount,
      'browsing_count': instance.browsingCount,
      'register_time': instance.registerTime,
      'meta': instance.meta,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return Meta(
    json['access_token'] as String,
    json['token_type'] as String,
    json['expires_in'] as int,
  );
}

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };
