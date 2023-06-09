import 'package:days_21/Data/Model/app_data.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  final PageController _pageController = PageController();
  int page = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page!.round() != page) {
        setState(() {
          page = _pageController.page!.round();
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final onBordings = AppData.onBordings;
    final ThemeData themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: themeData.colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  _PageView(
                      pageController: _pageController,
                      onBordings: onBordings,
                      themeData: themeData),
                  _PageIndicator(
                      pageController: _pageController, onBordings: onBordings),
                  SizedBox(
                      height: 49,
                      width: 113,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (page != 2) {
                            _pageController.animateToPage(page + 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          } else {}
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 24, fontFamily: 'iranYekan'),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          page == 2 ? 'شروع' : 'بعدی',
                          style:
                              TextStyle(color: themeData.colorScheme.surface),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required PageController pageController,
    required this.onBordings,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List<OnBording> onBordings;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: SmoothPageIndicator(
        controller: _pageController,
        count: onBordings.length,
        effect: CustomizableEffect(
          activeDotDecoration: DotDecoration(
              height: 18,
              width: 18,
              color: Colors.black,
              borderRadius: BorderRadius.circular(16)),
          dotDecoration: DotDecoration(
              height: 18,
              width: 18,
              borderRadius: BorderRadius.circular(16),
              dotBorder: const DotBorder(color: Colors.black)),
        ),
      ),
    );
  }
}

class _PageView extends StatelessWidget {
  const _PageView({
    required PageController pageController,
    required this.onBordings,
    required this.themeData,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List<OnBording> onBordings;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 490,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: onBordings.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 400,
                child: Image.asset('assets/images/${onBordings[index].image}'),
              ),
              const SizedBox(
                height: 8,
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 33),
                    child: _Background(
                      themeData: themeData,
                      onBordings: onBordings,
                      text: onBordings[index].line1,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _Background(
                      themeData: themeData,
                      onBordings: onBordings,
                      text: onBordings[index].line2,
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    required this.themeData,
    required this.onBordings,
    required this.text,
  });

  final ThemeData themeData;
  final List<OnBording> onBordings;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: themeData.colorScheme.primary,
        ),
        child: Text(
          text,
          style: themeData.textTheme.bodyMedium!
              .copyWith(fontSize: 20, color: themeData.colorScheme.surface),
        ),
      ),
    );
  }
}
