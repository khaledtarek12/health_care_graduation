import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/custom_stack_card.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/heart_beat_view.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/widgets/custom_container.dart';

class PatientViewBody extends StatelessWidget {
  const PatientViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      title: 'Home Page',
      isLeading: true,
      isLogout: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/clinical-trial-icon-2793430_1280.png',
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            const SizedBox(
                height:
                    100), // Add some spacing between the image and grid view
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
                    child: SvgPicture.asset(
                        'assets/images/chat-line-svgrepo-com.svg',
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(.8),
                        fit: BoxFit.contain),
                  ),
                  CustomStackCard(
                    child: SvgPicture.asset(
                      'assets/images/heart-beat-svgrepo-com.svg',
                      fit: BoxFit.contain,
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(.8),
                    ),
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
