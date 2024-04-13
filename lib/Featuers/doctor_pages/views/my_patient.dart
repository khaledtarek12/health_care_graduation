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
        title: "My Patients",
        child:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
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
