import 'package:days_21/Data/Common/http_response_validator.dart';
import 'package:days_21/Data/Model/user_reponse.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthDataSource {
  Future<void> sendSms(String phone);
  Future<UserReponse> verifyCode(String phone, String code);
}

class AuthRemoteDataSource
    with HttpResponseValidtor
    implements IAuthDataSource {
  final Dio httClient;

  AuthRemoteDataSource(this.httClient);
  @override
  Future<void> sendSms(String phone) async {
    final response = await httClient.post('get-sms', data: {'phone': phone});
    validateResponse(response);
    print(response.data['code']);
  }

  @override
  Future<UserReponse> verifyCode(String phone, String code) async {
    final response = await httClient.post('verify-code', data: {
      'phone': phone,
      'code': code,
    });
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('access_token', response.data['bearer_token']);
    final res2 = await httClient.get('my-profile');

    return UserReponse.fromJson(res2.data);
  }
}
