import 'package:flutter/material.dart';
import 'package:health_care/core/widgets/custom_container.dart';

import '../widgets/patient_card.dart';

class Mypatients extends StatelessWidget {
  const Mypatients({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomContainer(
        child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
          SliverToBoxAdapter(
              child: Center(
            child: Text(
              "My Patients",
              style: TextStyle(
                color: Color(0xff101A48),
                fontSize: 27,
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
          SliverToBoxAdapter(child: Patientcard()),
          SliverToBoxAdapter(child: Patientcard()),
          SliverToBoxAdapter(child: Patientcard()),
        ]),
      ),
    );
  }
}
