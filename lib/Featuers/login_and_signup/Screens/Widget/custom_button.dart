import 'package:flutter/material.dart';
import 'package:health_care/const.dart';

class CusttomButton extends StatelessWidget {
  const CusttomButton({super.key, this.onTap, required this.child});

  final VoidCallback? onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kprimaryDarkcolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
