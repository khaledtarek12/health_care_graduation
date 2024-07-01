import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/login_home_page.dart';
import 'package:health_care/Featuers/login_and_signup/bloc/login_cubit/login_cubit.dart';
import 'package:health_care/Featuers/screen_splash/bloc/cubit/get_my_data_cubit.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
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

class _DoctorHomepageState extends State<DoctorHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        title: 'Doctor Home Page',
        isLogout: true,
        child: CustomScrollView(slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 90),
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
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: kprimaryDarkcolor),
                      child: IconButton(
                          onPressed: () {
                            showQuesstionDialog(
                              context: context,
                              message: 'Are you sure you want to log out?',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
                                BlocProvider.of<LoginCubit>(context)
                                    .deleteEmail();
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginHomePage();
                                  },
                                ), (route) => false);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                    const SizedBox(
                      width: 15,
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
