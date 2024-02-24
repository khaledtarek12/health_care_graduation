import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/admin/views/widget/add_new_doctor.dart';
import 'package:health_care/Featuers/admin/views/widget/doctor_card.dart';
import 'package:health_care/Featuers/const.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';

class AdminScreenBody extends StatelessWidget {
  const AdminScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 180,
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          onPressed: () {
            Get.to(() => const AddNewDoctor(),
                duration: kDuration, transition: Motivation.zoomTransition());
          },
          child: const Text(
            'Add New Doctor',
            style: style15,
          ),
        ),
      ),
      body: CustomContainer(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return const DoctorCard();
          },
        ),
      ),
    );
  }
}
