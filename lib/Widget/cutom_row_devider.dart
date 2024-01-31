import 'package:flutter/material.dart';

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
            thickness: 2,
            height: 40,
            indent: 50,
          ),
        ),
        Text(
          '   or continue with   ',
          style: TextStyle(
            color: Color(0xffC6C6C6),
            fontSize: 13,
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            height: 40,
            endIndent: 50,
          ),
        )
      ],
    );
  }
}
