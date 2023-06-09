import 'package:days_21/common/exception.dart';
import 'package:dio/dio.dart';

mixin HttpResponseValidtor {
  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException(message: response.data['message']);
    }
  }
}
