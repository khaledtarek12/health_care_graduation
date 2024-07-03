import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/chat_page.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/login_home_page.dart';
import 'package:health_care/Featuers/login_and_signup/bloc/login_cubit/login_cubit.dart';
import 'package:health_care/Featuers/patient_pages/bloc/Alarms/alarm/alarm_data_cubit.dart';
import 'package:health_care/Featuers/patient_pages/views/heart_beat_view.dart';
import 'package:health_care/Featuers/patient_pages/views/history_of_patient_view.dart';
import 'package:health_care/Featuers/patient_pages/views/medical_information_page.dart';
import 'package:health_care/Featuers/screen_splash/bloc/cubit/get_my_data_cubit.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:health_care/core/widgets/custom_stack_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientViewBody extends StatefulWidget {
  const PatientViewBody({super.key});

  @override
  State<PatientViewBody> createState() => _PatientViewBodyState();
}

late SharedPreferences prefs;
String email = '';
getEmail() async {
  prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email')!;
}

@override
initState() {
  getEmail();
}

class _PatientViewBodyState extends State<PatientViewBody> {
  @override
  Widget build(BuildContext context) {
    GetMyDataCubit getMyDataCubit = BlocProvider.of<GetMyDataCubit>(context);

    return CustomContainer(
      title: 'Home Page',
      isLogout: true,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Container(
              margin: const EdgeInsets.only(top: 35),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/healthcare.png',
                    ),
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<GetMyDataCubit, GetMyDataState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: kprimaryDarkcolor),
                      child: IconButton(
                          onPressed: () {
                            showQuesstionDialog(
                              context: context,
                              message: 'Are you sure you want to log out?',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
                                BlocProvider.of<LoginCubit>(context)
                                    .deleteEmail();
                                BlocProvider.of<AlarmDataCubit>(context)
                                    .closeBox();
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginHomePage();
                                  },
                                ), (route) => false);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                    const SizedBox(width: 15),
                    Text('${getMyDataCubit.patientData.firstName} ',
                        style: style25.copyWith(color: kPrimaryColor)),
                    Text(getMyDataCubit.patientData.lastName,
                        style: style25.copyWith(color: Colors.white)),
                  ],
                );
              },
            ),
            const SizedBox(
                height: 50), // Add some spacing between the image and grid view
            SizedBox(
              height: 300, // Set a fixed height for the GridView
              child: GridView(
                clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 24.0, // Adjust mainAxisSpacing
                ),
                children: [
                  CustomStackCard(
                    children: [
                      Icon(
                        Icons.chat_rounded,
                        size: 90,
                        color: Colors.white.withOpacity(.7),
                      ),
                      const Text(
                        'My Chat',
                        style: style15,
                      ),
                    ],
                    onTap: () {
                      Get.to(
                          () => ChatPage(
                                senderEmail:
                                    getMyDataCubit.patientData.patientEmail,
                                recieverEmail:
                                    getMyDataCubit.patientData.doctorEmail!,
                              ),
                          transition: Motivation.zoomTransition());
                    },
                  ),
                  CustomStackCard(
                    children: [
                      Icon(
                        Icons.bar_chart_rounded,
                        size: 90,
                        color: Colors.white.withOpacity(.7),
                      ),
                      const Text(
                        'Heart rate',
                        style: style15,
                      ),
                    ],
                    onTap: () {
                      Get.to(() => const HeartBeatView(),
                          transition: Motivation.zoomTransition());
                    },
                  ),
                  CustomStackCard(
                    children: [
                      Icon(
                        Icons.history_edu_rounded,
                        size: 90,
                        color: Colors.white.withOpacity(.7),
                      ),
                      const Text(
                        'History',
                        style: style15,
                      ),
                    ],
                    onTap: () {
                      Get.to(
                        () => const HistoryOfPatientPage(),
                        transition: Motivation.zoomTransition(),
                        arguments: {
                          'doctorEmail': getMyDataCubit.patientData.doctorEmail,
                          'firstName': getMyDataCubit.patientData.firstName,
                          'lastName': getMyDataCubit.patientData.lastName,
                          // Add more arguments as needed
                        },
                      );
                    },
                  ),
                  CustomStackCard(
                    children: [
                      Icon(
                        Icons.medical_information_rounded,
                        size: 90,
                        color: Colors.white.withOpacity(.7),
                      ),
                      const Text(
                        'Informations',
                        style: style15,
                      ),
                    ],
                    onTap: () {
                      Get.to(() => const MedicalInformationPage(),
                          transition: Motivation.zoomTransition());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
