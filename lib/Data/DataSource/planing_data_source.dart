import 'package:days_21/Data/Common/http_response_validator.dart';
import 'package:days_21/Data/Model/plans_response.dart';
import 'package:days_21/Data/Model/user_reponse.dart';
import 'package:dio/dio.dart';

abstract class IPlaningDataSource {
  Future<User> getUser();
  Future<PlansResponse> getPlans();
  Future<String> buyPlan(int planId);
}

class PlaninRemoteDataSource
    with HttpResponseValidtor
    implements IPlaningDataSource {
  final Dio httClient;

  PlaninRemoteDataSource(this.httClient);

  @override
  Future<User> getUser() async {
    final response = await httClient.get('my-profile');
    validateResponse(response);
    return User.fromJson(response.data['user']);
  }

  @override
  Future<PlansResponse> getPlans() async {
    final response = await httClient.get('plans');
    validateResponse(response);
    return PlansResponse.fromJson(response.data);
  }

  @override
  Future<String> buyPlan(int planId) async {
    final response =
        await httClient.post('transactions/generate-link?plan_id=$planId');
    validateResponse(response);
    return response.data['link'];
  }
}
