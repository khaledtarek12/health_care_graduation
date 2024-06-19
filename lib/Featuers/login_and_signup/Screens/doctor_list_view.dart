import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/admin/bloc/get_doctor_cubit/get_doctors_cubit.dart';
import 'package:health_care/Featuers/admin/views/widget/doctor_card.dart';
import 'package:health_care/Featuers/login_and_signup/bloc/register_patient_cubit/register_cubit.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/circle_loading.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DoctorListViewBody extends StatefulWidget {
  const DoctorListViewBody({super.key});

  @override
  State<DoctorListViewBody> createState() => _DoctorListViewBodyState();
}

class _DoctorListViewBodyState extends State<DoctorListViewBody> {
  late GetDoctorsCubit getDoctorsCubit =
      BlocProvider.of<GetDoctorsCubit>(context);
  late RegisterCubit registerCubit = BlocProvider.of<RegisterCubit>(context);
  bool isLoading = false;
  String? doctorName;
  String? doctorEmail;
  int selectedCrad = -1;
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
          child: const Text('Choose Doctor', style: style15),
          onPressed: () {
            registerCubit.doctorName = doctorName!;
            registerCubit.doctorEmail = doctorEmail!;
            Navigator.of(context).pop();
          },
        ),
      ),
      body: CustomContainer(
        title: 'Doctors Card',
        isLeading: true,
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
              showErrorDialog(context: context, message: state.errorMessage);
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
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCrad = index;
                          doctorName =
                              '${getDoctorsCubit.allDoctors[index].fristName} ${getDoctorsCubit.allDoctors[index].lastName}';
                          doctorEmail = getDoctorsCubit.allDoctors[index].email;
                        });
                      },
                      child: selectedCrad == index
                          ? DoctorCard(
                              gradient: const LinearGradient(colors: [
                                kprimaryVeryDarkcolor,
                                kprimaryDarkcolor
                              ]),
                              isControled: false,
                              doctorModel: getDoctorsCubit.allDoctors[index])
                          : DoctorCard(
                              gradient: LinearGradient(
                                colors: [
                                  kPrimaryColor,
                                  kPrimaryColor.withOpacity(.6)
                                ],
                              ),
                              isControled: false,
                              doctorModel: getDoctorsCubit.allDoctors[index]),
                    ),
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
