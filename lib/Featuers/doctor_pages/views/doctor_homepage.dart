import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/login_and_signup/bloc/login_cubit/login_cubit.dart';
import 'package:health_care/Featuers/screen_splash/bloc/cubit/get_my_data_cubit.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import '../widgets/image.dart';
import 'card_patient_list_builder.dart';

class DoctorHomepage extends StatefulWidget {
  const DoctorHomepage({super.key});

  static const id = 'DoctorHomepage';

  @override
  State<DoctorHomepage> createState() => _DoctorHomepageState();
}

// String email = '';
// getEmail() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   email = prefs.getString('email')!;
// }

// initState() {
//   getEmail();
// }

class _DoctorHomepageState extends State<DoctorHomepage> {
  @override
  Widget build(BuildContext context) {
    log('emailkhaled: ${BlocProvider.of<LoginCubit>(context).email}');
    return Scaffold(
      body: CustomContainer(
        title: 'Doctor Home Page ',
        isLogout: true,
        child: CustomScrollView(slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 25),
          ),
          //image
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 170,
              child: ImagePage(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 15),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<GetMyDataCubit, GetMyDataState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_3_rounded,
                      color: Colors.white70,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      state is GetMyDataSuccess
                          ? '${BlocProvider.of<GetMyDataCubit>(context).doctorData.fName} '
                          : '',
                      style: style25.copyWith(color: kPrimaryColor),
                    ),
                    Text(
                      state is GetMyDataSuccess
                          ? BlocProvider.of<GetMyDataCubit>(context)
                              .doctorData
                              .lName
                          : '',
                      style: style25.copyWith(color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 25),
          ),
          //container
          const SliverToBoxAdapter(
            child: CardPatientListBuilder(),
          )
        ]),
      ),
    );
  }
}
