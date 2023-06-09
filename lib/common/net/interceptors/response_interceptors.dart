import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    RequestOptions option = response.requestOptions;

    late ResultData value;

    try {
      var header = response.headers[Headers.contentTypeHeader];
      if (header.toString().contains("text")) {
        value = ResultData(response.data, true, response.statusCode);
      } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
        value = ResultData(response.data, true, response.statusCode,
            headers: response.headers);
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print('${e.toString()}${option.path}');
      }
      value = ResultData(response.data, false, response.statusCode);
    }
    response.data = value;
    super.onResponse(response, handler);
  }
}
