import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/admin/views/widget/add_new_doctor.dart';
import 'package:health_care/Featuers/admin/views/widget/doctor_card.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/widgets/custom_container.dart';

class AdminScreenBody extends StatelessWidget {
  const AdminScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          shape: const CircleBorder(),
          onPressed: () {
            Get.to(() => const AddNewDoctor(),
                duration: kDuration, transition: Motivation.zoomTransition());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        color: kPrimaryColor,
        height: 75,
        shape: CircularNotchedRectangle(),
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
