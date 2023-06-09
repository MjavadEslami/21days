class UserReponse {
  late User user;
  // late CurrentPlan currentPlan;
  late List<Goal> goals;

  UserReponse.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    // if (json['current_plan'] != null) {
    //   currentPlan = CurrentPlan.fromJson(json['current_plan']);
    // }
    if (json['goals'] != null) {
      goals = <Goal>[];
      json['goals'].forEach((value) {
        goals.add(Goal.fromJson(value));
      });
    }
  }
}

class User {
  late int id;
  late String name;
  late String phone;
  late bool registerCompleted;
  late bool isPremium;
  late int premiumRemainingDays;
  late String avatarUrl;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    phone = json['phone'];
    registerCompleted = json['register_completed'];
    isPremium = json['is_premium'];
    premiumRemainingDays = json['premium_remaining_days'];
    avatarUrl = json['avatar_url'] ?? '';
  }
}

class CurrentPlan {
  late int id;
  late int totalPrice;
  late String title;
  late String subTitle1;
  late String subTitle2;
  late bool isUnlimited;

  CurrentPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['total_price'];
    title = json['title'];
    subTitle1 = json['subtitle_1'];
    subTitle2 = json['subtitle_2'];
    isUnlimited = json['is_unlimited'];
  }
}

class Goal {
  late int id;
  late String smallTitle;
  late String fullTitle;
  late String imageUrl;

  Goal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    smallTitle = json['small_title'];
    fullTitle = json['full_title'];
    imageUrl = json['image_url'];
  }
}
