import 'package:get/get.dart';
import 'package:health_care/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/screen_splash/views/splash_view.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro1.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro2.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro3.dart';
import 'package:health_care/screen_splash/views/widgets/screen_intro4.dart';

import 'login_and_signup/Screens/chat_page.dart';
import 'login_and_signup/Screens/cubits/chat/chat_cubit.dart';
import 'login_and_signup/Screens/cubits/login_cubit/login_cubit.dart';
import 'login_and_signup/Screens/cubits/register/register_cubit.dart';
import 'login_and_signup/Screens/entier_doctor_chatcall_page.dart';
import 'login_and_signup/Screens/login_home_page.dart';
import 'login_and_signup/Screens/signup_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: GetMaterialApp(
        routes: {
          Intro1.id: (context) => const Intro1(),
          Intro2.id: (context) => const Intro2(),
          Intro3.id: (context) => const Intro3(),
          Intro4.id: (context) => const Intro4(),
          LoginHomePage.id: (context) => const LoginHomePage(),
          SplashViewHome.id: (context) => const SplashViewHome(),
          SignupHomePage.id: (context) => const SignupHomePage(),
          ChatPage.id: (context) => ChatPage(),
          EntierCallChatScreen.id: (context) => const EntierCallChatScreen()
        },
        debugShowCheckedModeBanner: false,
        initialRoute: SplashViewHome.id,
      ),
    );
  }
}
