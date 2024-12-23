import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/add_bottom_sheet.dart';
import 'package:health_care/core/utils/styles.dart';

class AddAlramButton extends StatelessWidget {
  const AddAlramButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 3,
      color: kPrimaryColor.withOpacity(.9),
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      dashPattern: const [6, 8],
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: kPrimaryColor.withOpacity(.35),
            boxShadow: [
              BoxShadow(
                  color: Colors.transparent.withOpacity(.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(4, 4))
            ]),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 29),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddBottomSheet();
              },
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_alert, size: 45, color: Colors.white70),
              const SizedBox(height: 8),
              Text('Add Alarm',
                  style: styleNormal.copyWith(
                      color: Colors.white70, fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
