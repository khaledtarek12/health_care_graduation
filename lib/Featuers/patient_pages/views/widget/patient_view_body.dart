import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/heart_beat_view.dart';
import 'package:health_care/Featuers/screen_splash/bloc/cubit/get_my_data_cubit.dart';
import 'package:health_care/const.dart';
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
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/healthcare.png',
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_3, color: Colors.white, size: 45),
                const SizedBox(width: 5),
                Text('${getMyDataCubit.patientData.fristName} ',
                    style: style25.copyWith(color: kPrimaryColor)),
                Text(getMyDataCubit.patientData.lastName,
                    style: style25.copyWith(color: Colors.white)),
              ],
            ),
            const SizedBox(
                height: 70), // Add some spacing between the image and grid view
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
                  CustomStackCard(children: [
                    SvgPicture.asset(
                      'assets/images/chat-line-svgrepo-com.svg',
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(.8),
                      height: 100,
                      width: 100,
                    ),
                    const Text(
                      'My Chat',
                      style: style15,
                    ),
                  ]),
                  CustomStackCard(
                    children: [
                      SvgPicture.asset(
                        'assets/images/heart-beat-svgrepo-com.svg',
                        height: 100,
                        width: 100,
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(.8),
                      ),
                      const Text(
                        'Heart Info',
                        style: style15,
                      ),
                    ],
                    onTap: () {
                      Get.to(() => const HeartBeatView(),
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
