import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/admin/bloc/add_doctor_cubit/add_doctor_cubit.dart';
import 'package:health_care/Featuers/admin/bloc/delete_doctor_cubit/delete_doctor_cubit.dart';
import 'package:health_care/Featuers/admin/bloc/get_doctor_cubit/get_doctors_cubit.dart';
import 'package:health_care/Featuers/admin/views/admin_view_page.dart';
import 'package:health_care/Featuers/doctor_pages/bloc/get_patient_cubit/get_patient_cubit.dart';

import 'package:health_care/Featuers/doctor_pages/views/doctor_homepage.dart';
import 'package:health_care/Featuers/firebase_options.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/chat_page.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/login_home_page.dart';
import 'package:health_care/Featuers/patient_pages/cubits/alarm/alarm_data_cubit.dart';
import 'package:health_care/Featuers/patient_pages/data/services/notification_awsome.service.dart';
import 'package:health_care/Featuers/screen_splash/bloc/cubit/get_my_data_cubit.dart';
import 'package:health_care/Featuers/screen_splash/views/splash_view.dart';
import 'package:health_care/Featuers/screen_splash/views/widgets/splash_screen.dart';

import 'Featuers/login_and_signup/Screens/entier_doctor_chatcall_page.dart';
import 'Featuers/login_and_signup/Screens/signup_home_page.dart';
import 'Featuers/login_and_signup/bloc/chat/chat_cubit.dart';
import 'Featuers/login_and_signup/bloc/login_cubit/login_cubit.dart';
import 'Featuers/login_and_signup/bloc/register_patient_cubit/register_cubit.dart';
import 'Featuers/patient_pages/views/patient_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Notifications().initalizeNotification();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()..getEmail()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AlarmDataCubit()),
        BlocProvider(create: (context) => AddDoctorCubit()),
        BlocProvider(create: (context) => DeleteDoctorCubit()),
        BlocProvider(create: (context) => GetPatientsCubit()),
        BlocProvider(create: (context) => GetMyDataCubit()),
        BlocProvider(create: (context) => GetDoctorsCubit()..getAllDoctors()),
      ],
      child: GetMaterialApp(
        routes: {
          DoctorHomepage.id: (context) => const DoctorHomepage(),
          AdminViewPage.id: (context) => const AdminViewPage(),
          SplashScreen.id: (context) => const SplashScreen(),
          PatientView.id: (context) => const PatientView(),
          LoginHomePage.id: (context) => const LoginHomePage(),
          SplashViewHome.id: (context) => const SplashViewHome(),
          SignupHomePage.id: (context) => const SignupHomePage(),
          ChatPage.id: (context) => ChatPage(doctorId: ''),
          EntierCallChatScreen.id: (context) => const EntierCallChatScreen()
        },
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
      ),
    );
  }
}
