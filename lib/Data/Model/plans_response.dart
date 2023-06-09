class PlansResponse {
  late List<Plan> plans;
  PlansResponse.fromJson(Map<String, dynamic> json) {
    if (json['plans'] != null) {
      plans = <Plan>[];
      json["plans"].forEach((value) {
        plans.add(Plan.fromJson(value));
      });
    }
  }
}

class Plan {
  late int id;
  late int monthlyPrice;
  late int totalPrice;
  late String title;
  late String subTitle1;
  late String subTitle2;
  late String titleUnderPrice;
  late int days;
  late bool isUnlimited;

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    monthlyPrice = json['monthly_price'] ?? 0;
    totalPrice = json['total_price'];
    title = json['title'];
    subTitle1 = json['subtitle_1'];
    subTitle2 = json['subtitle_2'];
    titleUnderPrice = json['title_under_price'];
    days = json['days'] ?? 123456;
    isUnlimited = json['is_unlimited'];
  }
}
