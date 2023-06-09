import 'package:days_21/Data/DataSource/planing_data_source.dart';
import 'package:days_21/Data/Model/plans_response.dart';
import 'package:days_21/Data/Model/user_reponse.dart';
import 'package:days_21/common/http_client.dart';

abstract class IPlaningRepository {
  Future<User> getUser();
  Future<PlansResponse> getPlans();
  Future<String> buyPlan(int planId);
}

final planingRepository = PlaningRepository(PlaninRemoteDataSource(httClient));

class PlaningRepository implements IPlaningRepository {
  final IPlaningDataSource dataSource;

  PlaningRepository(this.dataSource);

  @override
  Future<PlansResponse> getPlans() async {
    return await dataSource.getPlans();
  }

  @override
  Future<User> getUser() async {
    return await dataSource.getUser();
  }

  @override
  Future<String> buyPlan(int planId) async {
    return await dataSource.buyPlan(planId);
  }
}
