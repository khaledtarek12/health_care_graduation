import 'package:flutter/material.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/utils/styles.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
    this.title,
  });

  final Widget? child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(title == null ? 'there is no title' : title!,
            style: style15.copyWith(fontSize: 20)),
        centerTitle: true,
        toolbarHeight: 110,
        toolbarOpacity: 0.8,
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          kPrimaryColor.withOpacity(.82),
          kPrimaryColor.withOpacity(.02),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: child,
      ),
    );
  }
}
