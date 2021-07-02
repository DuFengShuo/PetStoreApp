import 'package:json_annotation/json_annotation.dart';

part 'icons_bean.g.dart';

@JsonSerializable()
class IconsBean extends Object {
  @JsonKey(name: 'nationalFlag')
  NationalFlag nationalFlag;

  @JsonKey(name: 'education')
  Education education;

  @JsonKey(name: 'details')
  Details details;

  @JsonKey(name: 'message')
  String message;

  IconsBean(
    this.nationalFlag,
    this.education,
    this.details,
    this.message,
  );

  factory IconsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$IconsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IconsBeanToJson(this);
}

@JsonSerializable()
class NationalFlag extends Object {
  @JsonKey(name: 'in')
  String ins;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'sg')
  String sg;

  @JsonKey(name: 'ph')
  String ph;

  @JsonKey(name: 'my')
  String my;

  @JsonKey(name: 'th')
  String th;

  @JsonKey(name: 'vn')
  String vn;

  @JsonKey(name: 'default')
  String defaults;

  NationalFlag(
    this.ins,
    this.id,
    this.sg,
    this.ph,
    this.my,
    this.th,
    this.vn,
    this.defaults,
  );

  factory NationalFlag.fromJson(Map<String, dynamic> srcJson) =>
      _$NationalFlagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NationalFlagToJson(this);
}

@JsonSerializable()
class Education extends Object {
  @JsonKey(name: 'default')
  String defaults;

  Education(
    this.defaults,
  );

  factory Education.fromJson(Map<String, dynamic> srcJson) =>
      _$EducationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}

@JsonSerializable()
class Details extends Object {
  @JsonKey(name: 'industry')
  String industry;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'operatingStatus')
  String operatingStatus;

  @JsonKey(name: 'foundedDate')
  String foundedDate;

  @JsonKey(name: 'revenue')
  String revenue;

  @JsonKey(name: 'numOfPeople')
  String numOfPeople;

  @JsonKey(name: 'website')
  String website;

  @JsonKey(name: 'hq')
  String hq;

  Details(
    this.industry,
    this.phone,
    this.email,
    this.operatingStatus,
    this.foundedDate,
    this.revenue,
    this.numOfPeople,
    this.website,
    this.hq,
  );

  factory Details.fromJson(Map<String, dynamic> srcJson) =>
      _$DetailsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}
