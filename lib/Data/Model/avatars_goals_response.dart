class AvatarsGoalsRespone {
  late List<AvatarEntity> avatars;
  late List<GoalEntity> goals;

  AvatarsGoalsRespone.fromJosn(Map<String, dynamic> json) {
    if (json["avatars"] != null) {
      avatars = <AvatarEntity>[];
      json["avatars"].forEach((value) {
        avatars.add(AvatarEntity.fromJosn(value));
      });
    }

    if (json['goals'] != null) {
      goals = <GoalEntity>[];
      json['goals'].forEach((value) {
        goals.add(GoalEntity.fromJosn(value));
      });
    }
  }
}

class AvatarEntity {
  late int id;
  late String image;

  AvatarEntity.fromJosn(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image_url'];
  }
}

class GoalEntity {
  late int id;
  late String text;
  late String image;

  GoalEntity.fromJosn(Map<String, dynamic> json) {
    id = json['id'];
    text = json['full_title'];
    image = json['image_url'];
  }
}
