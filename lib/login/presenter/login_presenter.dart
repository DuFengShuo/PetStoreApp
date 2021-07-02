import 'package:local_life_app/common/common.dart';
import 'package:local_life_app/login/iview/login_iview.dart';
import 'package:local_life_app/login/models/captcha_image_bean.dart';
import 'package:local_life_app/login/models/captcha_sms_bean.dart';
import 'package:local_life_app/mvp/base_page_presenter.dart';
import 'package:local_life_app/login/models/user_bean.dart';
import 'package:local_life_app/net/dio_utils.dart';
import 'package:local_life_app/net/http_api.dart';
import 'package:local_life_app/util/sp_utils.dart';


class LoginPresenter extends BasePagePresenter<LoginIMvpView> {
  @override
  void initState() {
    super.initState();
  }

  Future login(Map<String, String> params) {
    return requestNetwork<UserBean>(Method.post,
        url: HttpApi.login,
        params: params,
        isShow: true, onSuccess: (UserBean model) async {
      if (model != null) {
        view.setUser(model);
        // SpUtil.putString(Constant.registerTime, model?.registerTime??"2021/01/01");
      }
    });
  }

  Future mobileLogin(Map<String, String> params) {
    return requestNetwork<UserBean>(Method.post,
        url: HttpApi.mobileLogin,
        params: params,
        isShow: true, onSuccess: (UserBean model) {
      if (model != null) {
        view.setUser(model);
        SpUtil.putString(
            Constant.registerTime, model.registerTime ?? "2021/01/01");

      }
    });
  }

  Future visitor(Map<String, String> params) {
    return requestNetwork<UserBean>(Method.post,
        url: HttpApi.visitor,
        params: params,
        isShow: true, onSuccess: (UserBean model) {
      if (model != null) {
        view.setUser(model);
      }
    });
  }
}

class SmsLoginPresenter extends BasePagePresenter<SmsLoginIMvpView> {
  Future captchaSms(Map<String, String> params) {
    return requestNetwork<CaptchaSmsBean>(Method.post,
        url: HttpApi.captchaSms,
        params: params,
        isShow: true, onSuccess: (CaptchaSmsBean model) {
      if (model != null) {
        if (model.message != null && model.message.isNotEmpty) {
          view.showToast(model.message);
        }
        view.provider.smsSubject.add(true);
        view.provider.setCaptchaSmsBean(model);
        view.setSemSuccess(true);
      } else {
        view.provider.smsSubject.add(false);
        view.setSemSuccess(false);
      }
    }, onError: (_, __) {
      view.provider.smsSubject.add(false);
      view.setSemSuccess(false);
    });
  }

  Future captchaImage(Map<String, String> params) {
    return requestNetwork<CaptchaImageBean>(Method.post,
        url: HttpApi.captchaImage,
        params: params,
        isShow: true, onSuccess: (CaptchaImageBean model) {
      if (model != null) {
        if (model.message != null && model.message.isNotEmpty) {
          view.showToast(model.message);
        }
        if (model.captchaImageContent.isNotEmpty) {
          String base64 = model.captchaImageContent
              .replaceAll('data:image/jpeg;base64,', '');
          view.showHintDialog(base64);
          view.provider.setCaptchaImageBean(model);
        }
      }
    });
  }
}
