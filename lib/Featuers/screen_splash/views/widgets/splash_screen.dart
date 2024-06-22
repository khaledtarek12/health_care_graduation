import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/screen_splash/views/widgets/logo_intro_screen.dart';
import 'package:health_care/Featuers/screen_splash/views/widgets/splash_view_body.dart';
import 'package:health_care/core/utils/splacsh_images.dart';
import 'package:health_care/core/widgets/box_decoration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToScreenIntro();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(splashPhoto),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: boxDecoration,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .55),
              child: LogoIntroScreen(
                  context: context, slideAnimation: slideAnimation),
            ),
          ),
        ),
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 1,
        ));
    slideAnimation = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }

  void navigateToScreenIntro() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.to(() => const SplashViewBody(),
            transition: Transition.circularReveal);
      },
    );
  }
}
