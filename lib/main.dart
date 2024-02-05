import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/doctor_pages/views/doctor_homepage.dart';
import 'package:health_care/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/screen_splash/views/splash_view.dart';
import 'package:health_care/login_and_signup/Screens/chat_page.dart';
import 'login_and_signup/Screens/entier_doctor_chatcall_page.dart';
import 'package:health_care/login_and_signup/Screens/login_home_page.dart';
import 'login_and_signup/Screens/signup_home_page.dart';
import 'login_and_signup/cubits/chat/chat_cubit.dart';
import 'login_and_signup/cubits/login_cubit/login_cubit.dart';
import 'login_and_signup/cubits/register/register_cubit.dart';

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
          DoctorHomepage.id: (context) => const DoctorHomepage(),
          LoginHomePage.id: (context) => const LoginHomePage(),
          SplashViewHome.id: (context) => const SplashViewHome(),
          SignupHomePage.id: (context) => const SignupHomePage(),
          ChatPage.id: (context) => ChatPage(),
          EntierCallChatScreen.id: (context) => const EntierCallChatScreen()
        },
        debugShowCheckedModeBanner: false,
        initialRoute: SplashViewHome.id,
        theme:
            ThemeData.light().copyWith(scaffoldBackgroundColor: kPrimaryColor),
      ),
    );
  }
}
