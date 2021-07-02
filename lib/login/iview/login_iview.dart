

import 'package:local_life_app/login/models/user_bean.dart';
import 'package:local_life_app/login/provider/login_page_provider.dart';
import 'package:local_life_app/mvp/mvps.dart';

abstract class LoginIMvpView implements IMvpView {
  void setUser(UserBean user);
  LoginPageProvider get provider;
}

abstract class SmsLoginIMvpView implements IMvpView {
  void showHintDialog(String base64Img);
  LoginPageProvider get provider;
  void setSemSuccess(bool onSuccess);
}
