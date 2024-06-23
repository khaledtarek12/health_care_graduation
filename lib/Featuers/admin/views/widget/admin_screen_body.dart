import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/admin/bloc/get_doctor_cubit/get_doctors_cubit.dart';
import 'package:health_care/Featuers/admin/views/widget/add_new_doctor.dart';
import 'package:health_care/Featuers/admin/views/widget/doctor_card.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/circle_loading.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AdminScreenBody extends StatefulWidget {
  const AdminScreenBody({super.key});

  @override
  State<AdminScreenBody> createState() => _AdminScreenBodyState();
}

class _AdminScreenBodyState extends State<AdminScreenBody> {
  late GetDoctorsCubit getDoctorsCubit =
      BlocProvider.of<GetDoctorsCubit>(context);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getDoctorsCubit.getAllDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: SizedBox(
        height: 50,
        width: 200,
        child: FloatingActionButton(
          backgroundColor: kprimaryDarkcolor,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            Get.to(() => const AddNewDoctor(),
                duration: kDuration, transition: Motivation.zoomTransition());
          },
          child: const Text('Add new Doctor', style: style15),
        ),
      ),
      body: CustomContainer(
        title: 'Doctors',
        isLogout: true,
        child: BlocConsumer<GetDoctorsCubit, GetDoctorsState>(
          listener: (context, state) {
            if (state is GetDoctorsLoading) {
              isLoading = true;
            } else {
              isLoading = false;
            }
            if (state is GetDoctorsFailure) {
              log(state.errorMessage);
              showErrorDialog(
                context: context,
                message: state.errorMessage,
                btnOkOnPress: () {},
              );
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              progressIndicator: const CircleLoading(),
              child: ListView.builder(
                itemCount: getDoctorsCubit.allDoctors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: DoctorCard(
                        // id: getDoctorsCubit.allDoctors[index].id,
                        gradient: LinearGradient(
                          colors: [
                            kPrimaryColor,
                            kPrimaryColor.withOpacity(.6)
                          ],
                        ),
                        isControled: true,
                        doctorModel: getDoctorsCubit.allDoctors[index]),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
