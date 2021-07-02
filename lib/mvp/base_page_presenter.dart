import 'package:dio/dio.dart';
import 'package:local_life_app/mvp/base_presenter.dart';
import 'package:local_life_app/net/net.dart';
import 'package:meta/meta.dart';

import 'mvps.dart';

class BasePagePresenter<V extends IMvpView> extends BasePresenter<V> {
  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  CancelToken _cancelToken;

  @override
  void dispose() {
    /// 销毁时，将请求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  /// 返回Future 适用于刷新，加载更多
  Future requestNetwork<T>(Method method,
      {@required String url,
      bool isShow = true,
      bool isClose = true,
      NetSuccessCallback<T> onSuccess,
      NetErrorCallback onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isUpdateImage = false}) {
    if (isShow) {
      view.showProgress();
    }
    return DioUtils.instance.requestNetwork<T>(
      method,
      url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      isUpdateImage: isUpdateImage,
      onSuccess: (data) {
        if (isClose) {
          view.closeProgress();
        }
        if (onSuccess != null) {
          onSuccess(data);
        }
      },
      onError: (code, msg) {
        _onError(code, msg, onError);
      },
    );
  }

  void asyncRequestNetwork<T>(
    Method method, {
    @required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T> onSuccess,
    NetErrorCallback onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) {
    if (isShow) {
      view.showProgress();
    }
    DioUtils.instance.asyncRequestNetwork<T>(
      method,
      url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSuccess: (data) {
        if (isClose) {
          view.closeProgress();
        }
        if (onSuccess != null) {
          onSuccess(data);
        }
      },
      onError: (code, msg) {
        _onError(code, msg, onError);
      },
    );
  }

  void _onError(int code, String msg, NetErrorCallback onError) {
    /// 异常时直接关闭加载圈，不受isClose影响
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error) {
      view.showToast(msg);
    }

    /// 页面如果dispose，则不回调onError
    if (onError != null && view.getContext() != null) {
      onError(code, msg);
    }
  }
}
