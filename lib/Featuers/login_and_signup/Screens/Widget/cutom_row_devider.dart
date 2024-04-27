import 'package:flutter/material.dart';
import 'package:health_care/const.dart';

class CustomRowDevider extends StatelessWidget {
  const CustomRowDevider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: kprimaryVeryDarkcolor,
            thickness: 2,
            height: 40,
            indent: 50,
          ),
        ),
        Text(
          '   or continue with   ',
          style: TextStyle(
            color: kprimaryVeryDarkcolor,
            fontSize: 13,
          ),
        ),
        Expanded(
          child: Divider(
            color: kprimaryVeryDarkcolor,
            thickness: 2,
            height: 40,
            endIndent: 50,
          ),
        )
      ],
    );
  }
}
