import 'package:flutter/material.dart';
import 'package:local_life_app/common/common.dart';
import 'package:local_life_app/login/models/user_bean.dart';

import 'package:sp_util/sp_util.dart';

class UserInfoProvider extends ChangeNotifier {
  UserBean _userModel;
  UserBean get userModel => _userModel ?? null;

  void setUserModel(UserBean userModel) async {
    _userModel = userModel;
    await SpUtil.putBool(Constant.isLogin, true);
    if (userModel.meta != null) {
      await SpUtil.putString(Constant.accessToken,
          '${userModel.meta.tokenType} ${userModel.meta.accessToken}');
      await SpUtil.putObject(Constant.userInfo, userModel);
    }
  }

  void setLogOut() async {
    _userModel = null;
    await SpUtil.putBool(Constant.isLogin, false);
    await SpUtil.putString(Constant.accessToken, '');
    await SpUtil.putObject(Constant.userInfo, null);
  }

  Map<dynamic, dynamic> _iconsBean;
  Map<dynamic, dynamic> get iconsBean => _iconsBean ?? null;

  setIconBean(Map<dynamic, dynamic> iconsBean) {
    _iconsBean = iconsBean;
  }
}
