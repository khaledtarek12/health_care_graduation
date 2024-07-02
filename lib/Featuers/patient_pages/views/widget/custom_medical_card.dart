import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/data/model/information_container_model.dart';

class CustomMedicalCrad extends StatelessWidget {
  const CustomMedicalCrad({super.key, required this.informationContainerModel});

  final InformationContainerModel informationContainerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: informationContainerModel.onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 200,
        decoration: BoxDecoration(
          color: informationContainerModel.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Image.asset(
              informationContainerModel.image,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            Text(
              informationContainerModel.text,
              maxLines: 2,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}