import 'package:json_annotation/json_annotation.dart';

part 'personnels_bean.g.dart';


@JsonSerializable()
class PersonalBean extends Object {

  @JsonKey(name: 'info')
  Info info;

  @JsonKey(name: 'summary')
  Summary summary;

  @JsonKey(name: 'colleagues')
  List<Colleagues> colleagues;

  @JsonKey(name: 'education')
  List<Education> education;

  @JsonKey(name: 'honors')
  List<Honors> honors;

  @JsonKey(name: 'skills')
  List<Skills> skills;

  @JsonKey(name: 'languages')
  List<String> languages;

  @JsonKey(name: 'message')
  String message;

  PersonalBean(this.info,this.summary,this.colleagues,this.education,this.honors,this.skills,this.languages,this.message,);

  factory PersonalBean.fromJson(Map<String, dynamic> srcJson) => _$PersonalBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonalBeanToJson(this);

}


@JsonSerializable()
class Info extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'tag')
  String tag;

  @JsonKey(name: 'twitter')
  String twitter;

  @JsonKey(name: 'linkedin')
  String linkedin;

  @JsonKey(name: 'facebook')
  String facebook;

  @JsonKey(name: 'youtube')
  String youtube;

  @JsonKey(name: 'instagram')
  String instagram;

  @JsonKey(name: 'github')
  String github;

  @JsonKey(name: 'position')
  List<Position> position;

  @JsonKey(name: 'intro')
  String intro;

  @JsonKey(name: 'is_collect')
  bool isCollect;

  @JsonKey(name: 'is_unlock')
  bool isUnlock;

  Info(this.id,this.avatar,this.name,this.tag,this.twitter,this.linkedin,this.facebook,this.youtube,this.instagram,this.github,this.position,this.intro,this.isCollect,this.isUnlock,);

  factory Info.fromJson(Map<String, dynamic> srcJson) => _$InfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoToJson(this);

}


@JsonSerializable()
class Position extends Object {

  @JsonKey(name: 'position')
  String position;

  @JsonKey(name: 'company_name')
  String companyName;

  Position(this.position,this.companyName,);

  factory Position.fromJson(Map<String, dynamic> srcJson) => _$PositionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PositionToJson(this);

}


@JsonSerializable()
class Summary extends Object {

  @JsonKey(name: 'overview')
  Overview overview;

  @JsonKey(name: 'contact_info')
  Contact_info contactInfo;

  Summary(this.overview,this.contactInfo,);

  factory Summary.fromJson(Map<String, dynamic> srcJson) => _$SummaryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SummaryToJson(this);

}


@JsonSerializable()
class Overview extends Object {

  @JsonKey(name: 'recent_experience')
  Recent_experience recentExperience;

  @JsonKey(name: 'recent_education')
  Recent_education recentEducation;

  @JsonKey(name: 'location')
  String location;

  Overview(this.recentExperience,this.recentEducation,this.location,);

  factory Overview.fromJson(Map<String, dynamic> srcJson) => _$OverviewFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OverviewToJson(this);

}


@JsonSerializable()
class Recent_experience extends Object {

  @JsonKey(name: 'company_id')
  String companyId;

  @JsonKey(name: 'company_name')
  String companyName;

  @JsonKey(name: 'company_logo')
  String companyLogo;

  Recent_experience(this.companyId,this.companyName,this.companyLogo,);

  factory Recent_experience.fromJson(Map<String, dynamic> srcJson) => _$Recent_experienceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Recent_experienceToJson(this);

}


@JsonSerializable()
class Recent_education extends Object {

  @JsonKey(name: 'edu_id')
  String eduId;

  @JsonKey(name: 'edu_name')
  String eduName;

  @JsonKey(name: 'edu_logo')
  String eduLogo;

  Recent_education(this.eduId,this.eduName,this.eduLogo,);

  factory Recent_education.fromJson(Map<String, dynamic> srcJson) => _$Recent_educationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Recent_educationToJson(this);

}


@JsonSerializable()
class Contact_info extends Object {

  @JsonKey(name: 'mobile')
  Mobile mobile;

  @JsonKey(name: 'email')
  Email email;

  Contact_info(this.mobile,this.email,);

  factory Contact_info.fromJson(Map<String, dynamic> srcJson) => _$Contact_infoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Contact_infoToJson(this);

}


@JsonSerializable()
class Mobile extends Object {

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'list')
  List<String> list;

  Mobile(this.total,this.list,);

  factory Mobile.fromJson(Map<String, dynamic> srcJson) => _$MobileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MobileToJson(this);

}


@JsonSerializable()
class Email extends Object {

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'list')
  List<String> list;

  Email(this.total,this.list,);

  factory Email.fromJson(Map<String, dynamic> srcJson) => _$EmailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EmailToJson(this);

}


@JsonSerializable()
class Colleagues extends Object {

  @JsonKey(name: 'info')
  Info info;

  @JsonKey(name: 'list')
  List<List> list;

  @JsonKey(name: 'total')
  int total;

  Colleagues(this.info,this.list,this.total,);

  factory Colleagues.fromJson(Map<String, dynamic> srcJson) => _$ColleaguesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColleaguesToJson(this);

}


@JsonSerializable()
class Info extends Object {

  @JsonKey(name: 'company_id')
  int companyId;

  @JsonKey(name: 'leave_time')
  int leaveTime;

  @JsonKey(name: 'entry_time')
  int entryTime;

  @JsonKey(name: 'company_name')
  String companyName;

  Info(this.companyId,this.leaveTime,this.entryTime,this.companyName,);

  factory Info.fromJson(Map<String, dynamic> srcJson) => _$InfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoToJson(this);

}


@JsonSerializable()
class List extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'position')
  String position;

  @JsonKey(name: 'is_collect')
  bool isCollect;

  @JsonKey(name: 'is_unlock')
  bool isUnlock;

  List(this.id,this.name,this.avatar,this.mobile,this.email,this.position,this.isCollect,this.isUnlock,);

  factory List.fromJson(Map<String, dynamic> srcJson) => _$ListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ListToJson(this);

}


@JsonSerializable()
class Education extends Object {

  @JsonKey(name: 'edu_name')
  String eduName;

  @JsonKey(name: 'edu_logo')
  String eduLogo;

  @JsonKey(name: 'edu_id')
  String eduId;

  @JsonKey(name: 'subject')
  String subject;

  @JsonKey(name: 'start_date')
  String startDate;

  @JsonKey(name: 'end_date')
  String endDate;

  @JsonKey(name: 'desc')
  String desc;

  Education(this.eduName,this.eduLogo,this.eduId,this.subject,this.startDate,this.endDate,this.desc,);

  factory Education.fromJson(Map<String, dynamic> srcJson) => _$EducationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EducationToJson(this);

}


@JsonSerializable()
class Honors extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'personnel_id')
  int personnelId;

  @JsonKey(name: 'honor_name')
  String honorName;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'deleted_at')
  String deletedAt;

  @JsonKey(name: 'organization_name')
  String organizationName;

  @JsonKey(name: 'year')
  int year;

  @JsonKey(name: 'desc')
  String desc;

  Honors(this.id,this.personnelId,this.honorName,this.createdAt,this.updatedAt,this.deletedAt,this.organizationName,this.year,this.desc,);

  factory Honors.fromJson(Map<String, dynamic> srcJson) => _$HonorsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HonorsToJson(this);

}


@JsonSerializable()
class Skills extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  Skills(this.id,this.name,);

  factory Skills.fromJson(Map<String, dynamic> srcJson) => _$SkillsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SkillsToJson(this);

}


