import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/admin/views/widget/edit_current_doctor.dart';
import 'package:health_care/Featuers/const.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(4, 4),
          ),
        ],
        gradient: LinearGradient(
          colors: [kPrimaryColor, kPrimaryColor.withOpacity(.6)],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Get.to(() => const EditCurrentDoctor(),
                      duration: kDuration,
                      transition: Motivation.zoomTransition());
                },
                backgroundColor: const Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: const Color.fromARGB(255, 165, 36, 3),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(
                    'assets/images/doctor (1).png',
                    fit: BoxFit.fill,
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'khaled tarek',
                      style: style15,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'tkhaled238@gmail.com',
                      style: styleNormal.copyWith(
                          color: Colors.white.withOpacity(.5), fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Passwords',
                      style: styleNormal.copyWith(
                          color: Colors.white.withOpacity(.5), fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '01552292680',
                      style: styleNormal.copyWith(
                          color: Colors.white.withOpacity(.5), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}