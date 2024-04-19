import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/login_home_page.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/utils/styles.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
    this.title,
    this.isLeading = false,
    this.isLogout = false,
  });

  final Widget? child;
  final String? title;
  final bool isLeading;
  final bool isLogout;
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
        actions: isLogout
            ? [
                IconButton(
                    onPressed: () {
                      showQuesstionDialog(
                        context: context,
                        message: 'Are you sure you want to log out?',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              return const LoginHomePage();
                            },
                          ), (route) => false);
                        },
                      );
                    },
                    icon: const Icon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Colors.white,
                    ))
              ]
            : null,
        leading: isLeading
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              )
            : null,
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
