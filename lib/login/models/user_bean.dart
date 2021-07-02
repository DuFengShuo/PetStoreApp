import 'package:json_annotation/json_annotation.dart';

part 'user_bean.g.dart';

@JsonSerializable()
class UserBean extends Object {
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'company_name')
  String companyName;

  @JsonKey(name: 'company_lnfo')
  String companyLnfo;

  @JsonKey(name: 'company_address')
  String companyAddress;

  @JsonKey(name: 'revenue')
  String revenue;

  @JsonKey(name: 'legal_represetive')
  String legalRepresetive;

  @JsonKey(name: 'created_at')
  int createdAt;

  @JsonKey(name: 'updated_at')
  int updatedAt;

  @JsonKey(name: 'favorite_count')
  int favoriteCount;

  @JsonKey(name: 'browsing_count')
  int browsingCount;

  @JsonKey(name: 'register_time')
  String registerTime;

  @JsonKey(name: 'meta')
  Meta meta;

  UserBean(
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.avatar,
    this.companyName,
    this.companyLnfo,
    this.companyAddress,
    this.revenue,
    this.legalRepresetive,
    this.createdAt,
    this.updatedAt,
    this.favoriteCount,
    this.browsingCount,
    this.registerTime,
    this.meta,
    this.message,
  );

  factory UserBean.fromJson(Map<String, dynamic> srcJson) =>
      _$UserBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserBeanToJson(this);
}

@JsonSerializable()
class Meta extends Object {
  @JsonKey(name: 'access_token')
  String accessToken;

  @JsonKey(name: 'token_type')
  String tokenType;

  @JsonKey(name: 'expires_in')
  int expiresIn;

  Meta(
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  );

  factory Meta.fromJson(Map<String, dynamic> srcJson) =>
      _$MetaFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
