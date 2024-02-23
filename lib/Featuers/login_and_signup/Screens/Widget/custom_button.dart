import 'package:flutter/material.dart';
import 'package:health_care/Featuers/const.dart';
import 'package:health_care/core/utils/styles.dart';

class CusttomButton extends StatelessWidget {
  const CusttomButton({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: onTap,
        child: Center(
          child: Text(text, style: style15.copyWith(fontSize: 18)),
        ),
      ),
    );
  }
}
