import 'package:flutter/material.dart';

import '../widgets/patient_card.dart';

class CardPatientListBuilder extends StatelessWidget {
  const CardPatientListBuilder({super.key, this.email});

  final Object? email;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Patientcard(
          email: email,
        );
      },
    );
  }
}
