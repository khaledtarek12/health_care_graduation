import 'package:flutter/material.dart';
import 'package:health_care/core/widgets/custom_container.dart';

import '../widgets/patient_card.dart';

class Mypatients extends StatelessWidget {
  const Mypatients({super.key});

  static const id = 'Mypatients';

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: CustomContainer(
        child:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          const SliverToBoxAdapter(
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
          SliverToBoxAdapter(
              child: CardListBuilder(
            email: email,
          )),
        ]),
      ),
    );
  }
}

class CardListBuilder extends StatelessWidget {
  const CardListBuilder({super.key, this.email});

  final Object? email;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Patientcard(
          email: email,
        );
      },
    );
  }
}
