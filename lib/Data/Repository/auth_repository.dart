import 'package:days_21/Data/DataSource/auth_data_source.dart';
import 'package:days_21/Data/Model/user_reponse.dart';
import 'package:days_21/common/http_client.dart';

abstract class IAuthRepository {
  Future<void> sendSms(String phone);
  Future<UserReponse> verfiCode(String phone, String code);
}

final authRepository = AuthRepository(AuthRemoteDataSource(httClient));

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> sendSms(String phone) async {
    await dataSource.sendSms(phone);
  }

  @override
  Future<UserReponse> verfiCode(String phone, String code) {
    return dataSource.verifyCode(phone, code);
  }
}
