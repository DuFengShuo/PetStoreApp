

import 'package:local_life_app/common/common.dart';

class BaseEntity<T> {
  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code] as int;
    message = json[Constant.message] as String;
    if (json.containsKey(Constant.data)) {
      data = _generateOBJ<T>(json[Constant.data]);
    }
  }

  int code;
  String message;
  T data;

  T _generateOBJ<T>(Object json) {
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else {
      /// List类型数据由fromJsonAsT判断处理
      // return JsonConvert.fromJsonAsT<T>(json);
      // return _fromJsonAsT<T>(json);
      return _FromType(T, json);
    }
  }

  // static M _fromJsonAsT<M>(json) {
  //   String type = M.toString();
  //   if (json is List && type.contains("List<")) {
  //     String itemType = type.substring(5, type.length - 1);
  //     return _FromListString(itemType, json);
  //   } else {
  //     return _FromType(M, json);
  //   }
  // }

  // // ignore: non_constant_identifier_names
  // static _FromListString(String type, json) {
  //   switch (type) {
  //     case 'AutocompleteBean':
  //       return getAutocompleteBeanList(json);
  //       break;
  //     case 'SearchBean':
  //       return getSearchBeanList(json);
  //       break;
  //     default:
  //       break;
  //   }
  // }

  // ignore: non_constant_identifier_names
  static _FromType(Type type, json) {
    // switch (type) {
    //   case BaseModel:
    //     return BaseModel.fromJson(json);
    //     break;
    //   case StatusModel:
    //     return StatusModel.fromJson(json);
    //     break;
    //   case UserBean:
    //     return UserBean.fromJson(json);
    //     break;
    //   case IconsBean:
    //     return IconsBean.fromJson(json);
    //     break;
    //   case MetaModel:
    //     return MetaModel.fromJson(json);
    //     break;
    //   case CaptchaImageBean:
    //     return CaptchaImageBean.fromJson(json);
    //     break;
    //   case CaptchaSmsBean:
    //     return CaptchaSmsBean.fromJson(json);
    //     break;
    //   case CompanyBean:
    //     return CompanyBean.fromJson(json);
    //     break;
    //   case PeoplesBean:
    //     return PeoplesBean.fromJson(json);
    //     break;
    //   case ProductsBean:
    //     return ProductsBean.fromJson(json);
    //     break;
    //   case AutocompleteBean:
    //     return AutocompleteBean.fromJson(json);
    //     break;
    //   case SearchBean:
    //     return SearchBean.fromJson(json);
    //     break;
    //   case CollectBean:
    //     return CollectBean.fromJson(json);
    //     break;
    //   case CompanyDetailsModel:
    //     return CompanyDetailsModel.fromJson(json);
    //     break;
    //   case PeoplesDetailsModel:
    //     return PeoplesDetailsModel.fromJson(json);
    //     break;
    //   case ProductDetailModel:
    //     return ProductDetailModel.fromJson(json);
    //     break;
    //   case WorksBean:
    //     return WorksBean.fromJson(json);
    //     break;
    //   case PeopleEducationsBean:
    //     return PeopleEducationsBean.fromJson(json);
    //     break;
    //   case BrowsingBean:
    //     return BrowsingBean.fromJson(json);
    //     break;
    //   case PeopleAchievementBean:
    //     return PeopleAchievementBean.fromJson(json);
    //     break;
    //   case TagsBean:
    //     return TagsBean.fromJson(json);
    //     break;
    //   case NewsBean:
    //     return NewsBean.fromJson(json);
    //     break;
    //   case RecommendBean:
    //     return RecommendBean.fromJson(json);
    //     break;
    //   case NewCompanyDetailBean:
    //     return NewCompanyDetailBean.fromJson(json);
    //     break;
    //   case HostWordBean:
    //     return HostWordBean.fromJson(json);
    //   case BrowsingModel:
    //     return BrowsingModel.fromJson(json);
    //     break;

    //   default:
    //     break;
    // }
  }
}
