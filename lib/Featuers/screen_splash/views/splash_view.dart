import 'package:flutter/material.dart';
import 'package:health_care/Featuers/screen_splash/views/widgets/splash_view_body.dart';

class SplashViewHome extends StatelessWidget {
  const SplashViewHome({super.key});

    static const id = 'SplashViewHome';


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}