import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:local_life_app/common/common.dart';
import 'package:local_life_app/util/device_utils.dart';
import 'package:local_life_app/util/jh_encrypt_utils.dart';
import 'package:local_life_app/util/log_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:sp_util/sp_util.dart';

import 'package:sprintf/sprintf.dart';

import 'dio_utils.dart';
import 'error_handle.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String accessToken = SpUtil.getString(Constant.accessToken);
    final Map<String, dynamic> params = await _getDeviceInfo();
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = '$accessToken';
    }
    options.headers['Accept'] = 'application/prs.flashinfo.v1+json';
    if (Constant.acceptDebug) {
      options.headers['content-type'] = 'application/x-www-form-urlencoded';
    }
    if (SpUtil.getString(Constant.locale) != null) {
      final String locale = SpUtil.getString(Constant.locale);
      options.headers['Accept-language'] = locale == 'zh' ? 'zh-CN' : 'en';
    } else {
      options.headers['Accept-language'] = 'zh-CN';
    }

    ///是否对数据加密
    options.headers['Accept-debug'] = Constant.acceptDebug ? '0' : '1';

    options.headers['Accept-data'] = Constant.acceptDebug
        ? JhEncryptUtils.aesMd5Base64(params)
        : jsonEncode(params).toString();

    super.onRequest(options, handler);
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    final Map<String, dynamic> params = <String, dynamic>{};
    if (Device.isWeb) {
      params['packageName'] = 'com.ww.advert';
      params['packageVersion'] = '7.0.10';
      params['packageVersionNumber'] = 7010;
      params['packagePlatform'] = 2; // 1 Android  2 ios
      params['packageChannelId'] = 2;
      params['bucketId'] = 1;
      params['uuid'] = '324';
      params['deviceModel'] = 'web';
    } else {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      params['packageName'] = packageInfo.packageName;
      params['packageVersion'] = packageInfo.version;
      params['packageVersionNumber'] = packageInfo.buildNumber;
      params['packagePlatform'] = Device.isIOS ? 2 : 1; // 1 Android  2 ios
      params['packageChannelId'] = 2;
      params['bucketId'] = 1;
      if (Device.isIOS) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        // 苹果系统
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        params['uuid'] = iosInfo.identifierForVendor;
        IosUtsname utsname = iosInfo.utsname;
        params['deviceModel'] = utsname.machine;
      } else if (Device.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        // 安卓系统
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        params['uuid'] = androidInfo.androidId;
        params['deviceModel'] = androidInfo.model;
      }
    }
    return params;
  }
}

class TokenInterceptor extends Interceptor {
  Dio _tokenDio;

  Future<String> getToken() async {
    try {
      _tokenDio ??= Dio();
      _tokenDio.options = DioUtils.instance.dio.options;
      _tokenDio.interceptors.add(AuthInterceptor());
      final Response response =
          await _tokenDio.put<dynamic>('authorization/refresh');
      if (response.statusCode == ExceptionHandle.success ||
          response.statusCode == ExceptionHandle.successs) {
        // UserBean userModel =
        //     UserBean.fromJson(json.decode(response.data.toString()));
        // await SpUtil.putString(Constant.accessToken,
        //     '${userModel.meta.tokenType} ${userModel.meta.accessToken}');
        // await SpUtil.putObject(Constant.userInfo, userModel);
        // return userModel.meta.accessToken;
      }
    } catch (e) {
      Log.e('刷新Token失败！');
    }
    return null;
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // final int loginTime = SpUtil.getInt(Constant.loginTime);
    // final int currentTime = DateTime.now().millisecondsSinceEpoch;
    // final int expiresIn = SpUtil.getInt(Constant.expiresIn);
    // bool isRefreshToken = false;
    // if (currentTime > loginTime + 600 && currentTime < loginTime + expiresIn) {
    //   isRefreshToken = true;
    // } else {
    //   isRefreshToken = false;
    // }
    //401代表token过期
    // if (response.statusCode == ExceptionHandle.unauthorized) {
    //   await SpUtil.putBool(Constant.isLogin, false);
    //   await SpUtil.putString(Constant.accessToken, '');
    //   await SpUtil.putInt(Constant.loginTime, 0);
    //   await SpUtil.putInt(Constant.expiresIn, 0);
    // }
    if (response != null &&
        response.statusCode == ExceptionHandle.unauthorized) {
      Log.d('-----------自动刷新Token------------');
      final Dio dio = DioUtils.instance.dio;
      dio.interceptors.requestLock.lock();
      final String accessToken = await getToken(); // 获取新的accessToken
      Log.e('-----------NewToken: $accessToken ------------');
      dio.interceptors.requestLock.unlock();

      if (accessToken != null) {
        // 重新请求失败接口
        final RequestOptions request = response.requestOptions;
        request.headers['Authorization'] = 'Bearer $accessToken';
        final Options options = Options(
          headers: request.headers,
          method: request.method,
        );
        try {
          Log.e('----------- 重新请求接口 ------------');

          /// 避免重复执行拦截器，使用tokenDio
          final Response response = await _tokenDio.request<dynamic>(
            request.path,
            data: request.data,
            queryParameters: request.queryParameters,
            cancelToken: request.cancelToken,
            options: options,
            onReceiveProgress: request.onReceiveProgress,
          );
          return handler.next(response);
        } on DioError catch (e) {
          return handler.reject(e);
        }
      }
    }
    super.onResponse(response, handler);
  }
}

class LoggingInterceptor extends Interceptor {
  DateTime _startTime;
  DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTime = DateTime.now();
    Log.d('----------Start----------');
    if (options.queryParameters.isEmpty) {
      Log.d('RequestUrl: ' + options.baseUrl + options.path);
    } else {
      Log.d('RequestUrl: ' +
          options.baseUrl +
          options.path +
          '?' +
          Transformer.urlEncodeMap(options.queryParameters));
    }
    Log.d('RequestMethod: ' + options.method);
    Log.d('RequestHeaders:' + options.headers.toString());
    Log.d('RequestContentType: ${options.contentType}');
    Log.d('RequestData: ${options.data.toString()}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _endTime = DateTime.now();
    final int duration = _endTime.difference(_startTime).inMilliseconds;
    if (response.statusCode == ExceptionHandle.success ||
        response.statusCode == ExceptionHandle.successs) {
      Log.d('ResponseCode: ${response.statusCode}');
    } else {
      Log.e('ResponseCode: ${response.statusCode}');
    }
    // 输出结果
    Log.json(response.data.toString());
    Log.d('----------End: $duration 毫秒----------');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.d('----------Error-----------');
    super.onError(err, handler);
  }
}

class AdapterInterceptor extends Interceptor {
  static const String _kMsg = 'msg';
  static const String _kSlash = '\'';
  static const String _kMessage = 'message';

  // static const String _kDefaultText = '"无返回信息"';
  // static const String _kNotFound = '未找到查询信息';
  static const String _kDefaultText = '"No return message"';
  static const String _kNotFound = 'Query information not found';

  static const String _kFailureFormat = '{"code":%d,"message":"%s"}';
  static const String _kSuccessFormat = '{"code":0,"data":%s,"message":""}';
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final Response r = adapterData(response);
    super.onResponse(r, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      adapterData(err.response);
    }
    super.onError(err, handler);
  }

  Response adapterData(Response response) {
    String result;
    String content = response.data?.toString() ?? '';
    if (Constant.acceptDebug) {
      content = JhEncryptUtils.decMd5Base64(content);
    }

    /// 成功时，直接格式化返回
    if (response.statusCode == ExceptionHandle.success ||
        response.statusCode == ExceptionHandle.successs ||
        response.statusCode == ExceptionHandle.success_not_content) {
      if (content.isEmpty) {
        content = _kDefaultText;
      }

      result = sprintf(_kSuccessFormat, [content]);
      response.statusCode = ExceptionHandle.success;
    } else {
      if (response.statusCode == ExceptionHandle.not_found) {
        /// 错误数据格式化后，按照成功数据返回
        result = sprintf(_kFailureFormat, [response.statusCode, _kNotFound]);
        response.statusCode = ExceptionHandle.success;
      } else {
        if (content.isEmpty) {
          // 一般为网络断开等异常
          result = content;
        } else {
          String msg;
          try {
            // content = content.replaceAll(r'\', '');
            if (_kSlash == content.substring(0, 1)) {
              content = content.substring(1, content.length - 1);
            }
            final Map<String, dynamic> map =
                json.decode(content) as Map<String, dynamic>;
            if (map.containsKey(_kMessage)) {
              msg = map[_kMessage] as String;
            } else if (map.containsKey(_kMsg)) {
              msg = map[_kMsg] as String;
            } else {
              // msg = '未知异常';
              msg = 'Unknown abnormal';
            }
            result = sprintf(_kFailureFormat, [response.statusCode, msg]);
            // 401 token失效时，单独处理，其他一律为成功
            if (response.statusCode == ExceptionHandle.unauthorized) {
              response.statusCode = ExceptionHandle.unauthorized;
            } else {
              response.statusCode = ExceptionHandle.success;
            }
          } catch (e) {
//            Log.d('异常信息：$e');
            // 解析异常直接按照返回原数据处理（一般为返回500,503 HTML页面代码）
            // result = sprintf(_kFailureFormat,
            //     [response.statusCode, '服务器异常(${response.statusCode})']);
            result = sprintf(_kFailureFormat, [
              response.statusCode,
              'Server exception(${response.statusCode})'
            ]);
          }
        }
      }
    }
    response.data = result;
    return response;
  }
}
