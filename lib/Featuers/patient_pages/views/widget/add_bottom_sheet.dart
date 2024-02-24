import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/bottom_sheet.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context)
                .padding
                .bottom, // Adjust padding to accommodate the keyboard
      ),
      child: const SingleChildScrollView(
        child: BottomSheetpage(),
      ),
    );
  }
}
