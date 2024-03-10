import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/screen_splash/views/widgets/intro_screen.dart';
import 'package:health_care/Featuers/screen_splash/views/widgets/splash3.dart';
import 'package:health_care/Featuers/screen_splash/views/widgets/splash2.dart';
import 'package:health_care/core/utils/splacsh_images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'custom_splash_button.dart';
import 'splash1.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  late PageController pageController;
  bool isLastPage = false;
  int pageNumber = 0;
  final images = [intro1, intro2, intro3];

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
    return OrientationBuilder(
      builder: (context, orientation) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      pageNumber = index;
                      isLastPage = (index == images.length - 1);
                    });
                  },
                  children: images.map((assetName) {
                    return IntroScreen(assetName: assetName);
                  }).toList(),
                ),
                Container(
                  alignment: const Alignment(0, 0.7),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
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
                      isLastPage: isLastPage,
                      pageController: pageController,
                    ),
                  ),
                ),
                _buildSplashText(orientation),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSplashText(Orientation orientation) {
    switch (pageNumber) {
      case 0:
        return Splsh1(orientation: orientation);
      case 1:
        return Splash2(orientation: orientation);
      case 2:
        return Splash3(orientation: orientation);
      default:
        return const SizedBox.shrink();
    }
  }
}
