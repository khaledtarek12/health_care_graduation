import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/doctor_pages/bloc/get_patient_cubit/get_patient_cubit.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/patient_card.dart';

class CardPatientListBuilder extends StatefulWidget {
  const CardPatientListBuilder({super.key, this.email});

  final Object? email;

  @override
  State<CardPatientListBuilder> createState() => _CardPatientListBuilderState();
}

class _CardPatientListBuilderState extends State<CardPatientListBuilder> {
  late GetPatientsCubit getPatientsCubit =
      BlocProvider.of<GetPatientsCubit>(context);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPatientsCubit.getAllPatients(email: widget.email!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPatientsCubit, GetPatientsState>(
      listener: (context, state) {
        if (state is GetPatientsLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
        if (state is GetPatientsFailure) {
          log(state.errorMessage);
          showErrorDialog(context: context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: getPatientsCubit.allPatient.length,
            itemBuilder: (context, index) {
              return Patientcard(
                patientModel: getPatientsCubit.allPatient[index],
                email: widget.email,
              );
            },
          ),
        );
      },
    );
  }
}
