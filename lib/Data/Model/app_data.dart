class OnBording {
  final String line1;
  final String line2;
  final String image;

  OnBording({required this.line1, required this.line2, required this.image});
}

class AppData {
  static List<OnBording> get onBordings {
    return [
      OnBording(
        line1: 'اینجا قراره عادت هایی رو بسازی که',
        line2: 'نگرانی و اضطراب رو ازت  دور می کنن.',
        image: 'on1.PNG',
      ),
      OnBording(
        line1: ' اینجا قدم به قدم مسیر ساختن عادت',
        line2: 'های جدید رو یاد می گیری.',
        image: 'on2.PNG',
      ),
      OnBording(
        line1: 'عادت هایی که سرزنش رو با حس',
        line2: 'رضایت جایگزین میکنن.',
        image: 'on3.PNG',
      ),
    ];
  }
}
