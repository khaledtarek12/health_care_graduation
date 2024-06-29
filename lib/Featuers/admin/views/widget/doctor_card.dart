import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/admin/bloc/delete_doctor_cubit/delete_doctor_cubit.dart';
import 'package:health_care/Featuers/admin/bloc/get_doctor_cubit/get_doctors_cubit.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/Featuers/admin/views/widget/edit_current_doctor.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';

// ignore: must_be_immutable
class DoctorCard extends StatelessWidget {
  DoctorCard({
    super.key,
    required this.doctorModel,
    this.isControled = false,
    this.gradient,
  });

  final DoctorModel doctorModel;
  final bool isControled;
  // final int? id;
  Gradient? gradient = LinearGradient(
    colors: [kPrimaryColor, kPrimaryColor.withOpacity(.6)],
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteDoctorCubit, DeleteDoctorState>(
      listener: (context, state) {
        if (state is DeleteDoctorLoading) {
          BlocProvider.of<GetDoctorsCubit>(context).getAllDoctors();
        } else if (state is DeleteDoctorSuccess) {
          BlocProvider.of<GetDoctorsCubit>(context).getAllDoctors();
        } else if (state is DeleteDoctorFailure) {
          showErrorDialog(
            context: context,
            message: 'Oops , there was an error',
            btnOkOnPress: () {},
          );
          BlocProvider.of<GetDoctorsCubit>(context).getAllDoctors();
        }
      },
      builder: (context, state) {
        return Container(
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
            gradient: gradient,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Slidable(
              startActionPane: isControled
                  ? ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Get.to(
                                () =>
                                    EditCurrentDoctor(doctorModel: doctorModel),
                                duration: kDuration,
                                transition: Motivation.zoomTransition());
                          },
                          backgroundColor: const Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.edit_square,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (slideContext) {
                            showQuesstionDialog(
                              context: context,
                              message: 'Are you sure to delete Doctor Card',
                              btnOkOnPress: () {
                                BlocProvider.of<DeleteDoctorCubit>(context)
                                    .deleteDoctor(
                                        userId: doctorModel.userId!,
                                        email: doctorModel.email,
                                        password: doctorModel.password);
                                BlocProvider.of<GetDoctorsCubit>(context)
                                    .getAllDoctors();
                              },
                              btnCancelOnPress: () {
                                BlocProvider.of<GetDoctorsCubit>(context)
                                    .getAllDoctors();
                              },
                            );
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 165, 36, 3),
                          foregroundColor:
                              const Color.fromARGB(255, 51, 23, 23),
                          icon: FontAwesomeIcons.trash,
                          label: 'Delete',
                        ),
                      ],
                    )
                  : null,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Image.asset(
                        'assets/images/doctor.png',
                        fit: BoxFit.fill,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${doctorModel.fName} ${doctorModel.lName}',
                          style: style15,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          doctorModel.email,
                          style: styleNormal.copyWith(
                              color: Colors.white.withOpacity(.5),
                              fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          doctorModel.password,
                          style: styleNormal.copyWith(
                              color: Colors.white.withOpacity(.5),
                              fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          doctorModel.phoneNumber,
                          style: styleNormal.copyWith(
                              color: Colors.white.withOpacity(.5),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
