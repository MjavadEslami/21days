import 'package:days_21/Data/Common/http_response_validator.dart';
import 'package:days_21/Data/Model/avatars_goals_response.dart';
import 'package:dio/dio.dart';

abstract class ISingAvatarDataSource {
  Future<AvatarsGoalsRespone> getData();
  Future<void> regiserNameAndAvatar(String name, int imageId);
  Future<void> updateGoals(List<int> goalsId);
}

class SingAvatarRemoteDataSource
    with HttpResponseValidtor
    implements ISingAvatarDataSource {
  final Dio httClient;

  SingAvatarRemoteDataSource(this.httClient);
  @override
  Future<AvatarsGoalsRespone> getData() async {
    final response = await httClient.get('splash');
    validateResponse(response);
    return AvatarsGoalsRespone.fromJosn(response.data);
  }

  @override
  Future<void> regiserNameAndAvatar(String name, int imageId) async {
    await httClient
        .post('my-profile/update', data: {'name': name, 'avatar_id': imageId});
  }

  @override
  Future<void> updateGoals(List<int> goalsId) async {
    await httClient
        .post('my-profile/update-goals', data: {'goal_ids': goalsId});
  }
}
