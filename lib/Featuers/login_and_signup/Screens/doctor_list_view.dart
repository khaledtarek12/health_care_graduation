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
  int selectedCard = -1;
  late String doctorName = '';
  late String doctorEmail = '';
  late int doctorId = -1;

  @override
  void initState() {
    super.initState();
    getDoctorsCubit.getAllDoctors();
    doctorEmail = registerCubit.doctorEmail;
    doctorName = registerCubit.doctorName;
    doctorId = registerCubit.doctorId;
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
            setState(() {
              registerCubit.doctorName = doctorName;
              registerCubit.doctorEmail = doctorEmail;
              registerCubit.doctorId = doctorId;
            });
            Navigator.of(context).pop({
              'doctorName': doctorName,
              'doctorEmail': doctorEmail,
              'doctorId': doctorId.toString(),
            });
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
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
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
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCard = index;
                          doctorName =
                              '${getDoctorsCubit.allDoctors[index].fName} ${getDoctorsCubit.allDoctors[index].lName}';
                          doctorEmail = getDoctorsCubit.allDoctors[index].email;
                          doctorId = getDoctorsCubit.allDoctors[index].id!;
                        });
                      },
                      child: selectedCard == index
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
