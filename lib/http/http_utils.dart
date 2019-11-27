
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
///https://blog.csdn.net/yechaoa/article/details/90234708
class HttpUtils
{
  static final HttpUtils _instance = HttpUtils._internal();

  static get instance=>_instance;//直接访问instance是单例，下面如果外面每次new HttpUtils()也是单例

  Dio _client;

  factory HttpUtils() => _instance;

  HttpUtils._internal() {
    if (null == _client) {
      BaseOptions options = new BaseOptions(
        baseUrl: "https://www.wanandroid.com",
        connectTimeout: 5000,
        receiveTimeout: 3000,
        contentType: "application/x-www-form-urlencoded"
        //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
        //responseType: ResponseType.json
      );
      _client = new Dio(options);
      //_client.httpClientAdapter=xxxxx;可以切换底层库
      //添加cookie管理
      _client.interceptors.add(CookieManager(CookieJar()));

      //添加拦截器
      _client.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print("请求之前");
        // Do something before request is sent
        return options; //continue
      }, onResponse: (Response response) {
        print("响应之前:${response.request.uri}");
        // Do something with response data
        return response; // continue
      }, onError: (DioError e) {
        print("错误之前");
        // Do something with response error
        return e; //continue
      }));


    }
  }

  /*
   * get请求
   * options 目的：
   * BaseOptions 基类请求配置  Options单次请求配置   RequestOptions实际请求配置
   */
  Future<String> get(url, {data, options, cancelToken}) async {
    Response<String> response;
    try {
      response = await _client.get(url, queryParameters: data, options: options, cancelToken: cancelToken);
      print('get success---------${response.statusCode}');
      print('get success---------${response.data}');

//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码

    } on DioError catch (e) {
      print('get error---------$e');
      formatError(e);
    }
    return response.data;
  }



  /*
   * post请求
   */
  post(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await _client.post(url, queryParameters: data, options: options, cancelToken: cancelToken);
      print('post success---------${response.data}');
    } on DioError catch (e) {
      print('post error---------$e');
      formatError(e);
    }
    return response.data;
  }


  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await _client.download(urlPath, savePath,onReceiveProgress: (int count, int total){
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response.data;
  }


  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }


}

