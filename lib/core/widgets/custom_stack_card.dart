import 'package:flutter/material.dart';

import 'package:health_care/const.dart';

class CustomStackCard extends StatelessWidget {
  const CustomStackCard({super.key, required this.children, this.onTap});

  final List<Widget> children;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [kPrimaryColor, kPrimaryColor.withOpacity(.6)]),
            boxShadow: [
              BoxShadow(
                  color: kPrimaryColor.withOpacity(.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(4, 4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
