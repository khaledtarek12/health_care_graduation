import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro1.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro2.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro3.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro4.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'custom_splash_button.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  late PageController pageController;
  bool isLastPage = false;
  int pageNumber = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: pageNumber);
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
                pageNumber = index;
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
            effect: const WormEffect(
              dotHeight: 20,
              dotWidth: 20,
              spacing: 10,
              activeDotColor: kPrimaryColor,
              radius: 8,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, .9),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 50,
            width: double.infinity,
            child: CustomSplashButton(
                isLastPage: isLastPage, pageController: pageController),
          ),
        ),
        pageNumber == 0
            ? _splash0()
            : pageNumber == 1
                ? _splash1()
                : pageNumber == 2
                    ? _splash2()
                    : _splash3(),
      ],
    );
  }

  Padding _splash0() {
    return Padding(
      padding: const EdgeInsets.only(top: 280),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to',
            style: style28.copyWith(fontSize: 35),
          ),
          Text(
            'Elderly',
            style: style28.copyWith(fontSize: 35),
          ),
          const SizedBox(height: 40),
          const Text(
            textAlign: TextAlign.center,
            'Taking care of the elderly through a sensor to measure his vital rates',
            style: style15,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Padding _splash3() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 320),
          Text(
            textAlign: TextAlign.center,
            'Your best solution to follow up your health from home ',
            style: style28,
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  Column _splash2() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 320),
        Text(
          textAlign: TextAlign.center,
          'Enter your medication appointments and let us remind you ',
          style: style28,
        ),
        SizedBox(height: 80),
      ],
    );
  }

  Padding _splash1() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 320),
          Text(
            textAlign: TextAlign.center,
            'Check on your health status and follow up on your vital rates',
            style: style28,
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
