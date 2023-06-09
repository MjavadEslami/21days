import 'package:days_21/Data/DataSource/sing_avatar_data_source.dart';
import 'package:days_21/Data/Model/avatars_goals_response.dart';
import 'package:days_21/common/http_client.dart';

abstract class ISingAvatarRepository {
  Future<AvatarsGoalsRespone> getData();
  Future<void> regiserNameAndAvatar(String name, int imageId);
  Future<void> updateGoals(List<int> goalsId);
}

final singAvatarRepository =
    SingAvatarRepository(SingAvatarRemoteDataSource(httClient));

class SingAvatarRepository implements ISingAvatarRepository {
  final ISingAvatarDataSource dataSource;

  SingAvatarRepository(this.dataSource);

  @override
  Future<AvatarsGoalsRespone> getData() async {
    return await dataSource.getData();
  }

  @override
  Future<void> regiserNameAndAvatar(String name, int imageId) async {
    return await dataSource.regiserNameAndAvatar(name, imageId);
  }

  @override
  Future<void> updateGoals(List<int> goalsId) async {
    return await dataSource.updateGoals(goalsId);
  }
}
