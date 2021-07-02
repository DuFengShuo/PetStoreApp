// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icons_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IconsBean _$IconsBeanFromJson(Map<String, dynamic> json) {
  return IconsBean(
    json['nationalFlag'] == null
        ? null
        : NationalFlag.fromJson(json['nationalFlag'] as Map<String, dynamic>),
    json['education'] == null
        ? null
        : Education.fromJson(json['education'] as Map<String, dynamic>),
    json['details'] == null
        ? null
        : Details.fromJson(json['details'] as Map<String, dynamic>),
    json['message'] as String,
  );
}

Map<String, dynamic> _$IconsBeanToJson(IconsBean instance) => <String, dynamic>{
      'nationalFlag': instance.nationalFlag,
      'education': instance.education,
      'details': instance.details,
      'message': instance.message,
    };

NationalFlag _$NationalFlagFromJson(Map<String, dynamic> json) {
  return NationalFlag(
    json['in'] as String,
    json['id'] as String,
    json['sg'] as String,
    json['ph'] as String,
    json['my'] as String,
    json['th'] as String,
    json['vn'] as String,
    json['default'] as String,
  );
}

Map<String, dynamic> _$NationalFlagToJson(NationalFlag instance) =>
    <String, dynamic>{
      'in': instance.ins,
      'id': instance.id,
      'sg': instance.sg,
      'ph': instance.ph,
      'my': instance.my,
      'th': instance.th,
      'vn': instance.vn,
      'default': instance.defaults,
    };

Education _$EducationFromJson(Map<String, dynamic> json) {
  return Education(
    json['default'] as String,
  );
}

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'default': instance.defaults,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return Details(
    json['industry'] as String,
    json['phone'] as String,
    json['email'] as String,
    json['operatingStatus'] as String,
    json['foundedDate'] as String,
    json['revenue'] as String,
    json['numOfPeople'] as String,
    json['website'] as String,
    json['hq'] as String,
  );
}

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'industry': instance.industry,
      'phone': instance.phone,
      'email': instance.email,
      'operatingStatus': instance.operatingStatus,
      'foundedDate': instance.foundedDate,
      'revenue': instance.revenue,
      'numOfPeople': instance.numOfPeople,
      'website': instance.website,
      'hq': instance.hq,
    };
