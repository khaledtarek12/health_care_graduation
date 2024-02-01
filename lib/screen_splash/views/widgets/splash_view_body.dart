import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/login_and_signup/Screens/login_home_page.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro1.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro2.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro3.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro4.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  late PageController pageController;
  bool isLastPage = false;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 3);
              });
            },
            children: const [
              Intro1(),
              Intro2(),
              Intro3(),
              Intro4(),
            ]),
        Container(
          alignment: const Alignment(0, 0.55),
          child: SmoothPageIndicator(
            controller: pageController,
            count: 4,
            effect: const ExpandingDotsEffect(
              activeDotColor: kPrimaryColor,
              dotColor: kPrimaryColor,
              dotHeight: 20,
              dotWidth: 20,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, .9),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  isLastPage
                      ? Get.to(() => const LoginHomePage(),
                          transition: Transition.downToUp,
                          duration: kDuration)
                      : pageController.nextPage(
                          duration: kDuration,
                          curve: Curves.easeIn);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: isLastPage
                    ? const Text(
                        'Get Started',
                        style: style15,
                      )
                    : const Text(
                        'Next',
                        style: style15,
                      )),
          ),
        ),
      ],
    );
  }
}
