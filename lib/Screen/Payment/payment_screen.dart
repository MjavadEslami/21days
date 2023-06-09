import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final String image;
  final String name;
  final int orderId;
  final int status;
  const PaymentScreen(
      {super.key,
      required this.orderId,
      required this.status,
      required this.image,
      required this.name});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: themeData.colorScheme.primary,
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 145,
                  ),
                  Positioned(
                    top: -8,
                    left: -30,
                    child: Transform.rotate(
                      angle: 800 / 1,
                      child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(8 / 5),
                          child: Image.asset(
                            'assets/images/logo-w.png',
                            height: 120,
                          )),
                    ),
                  ),
                ],
              ),
              Hero(
                tag: 'avatar',
                child: CachedNetworkImage(imageUrl: image),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  status == 1
                      ? '$name عزیز، ممنونیم از اعتماد و انتخابت، این یه شروع جدید واسه‌ی زندگیته، امیدواریم با تعهد تا تهش پیش بری و خیلی زود اون سبک زندگی دلخواه‌ت رو به دست بیاری.'
                      : 'متاسفانه پرداخت شما موفقیت آمیز نبود، در صورت کسر وجه تا ۷۲ ساعت آینده به حساب شما باز خواهد گشت.',
                  style: themeData.textTheme.bodyMedium!
                      .copyWith(color: themeData.colorScheme.surface),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 34,
                child: Padding(
                  padding: const EdgeInsets.only(left: 90, right: 90),
                  child: ElevatedButton(
                    onPressed: () {
                      if (status == 0) {
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeData.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      status == 1 ? 'انتقال به صفحه اصلی' : 'بازگشت',
                      style: TextStyle(color: themeData.colorScheme.primary),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Image.asset(
                            'assets/images/Days.png',
                            width: 128,
                            height: 80,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -4,
                        right: 82,
                        child: Image.asset(
                          'assets/images/21.png',
                          width: 98,
                          height: 133,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
