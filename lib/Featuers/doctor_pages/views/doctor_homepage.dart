import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:health_care/core/widgets/custom_container.dart';
import '../widgets/image.dart';
import 'card_patient_list_builder.dart';

class DoctorHomepage extends StatelessWidget {
  const DoctorHomepage({super.key});

  static const id = 'DoctorHomepage';

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: CustomContainer(
        title: 'Doctor Home Page ',
        isLeading: true,
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
            child: Row(
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
                  'Khaled',
                  style: style25.copyWith(color: kPrimaryColor),
                ),
                Text(
                  ' Tarek',
                  style: style25.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 25),
          ),
          //container
          SliverToBoxAdapter(
            child: CardPatientListBuilder(
              email: email,
            ),
          )
        ]),
      ),
    );
  }
}
