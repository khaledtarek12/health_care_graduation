import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/widgets/custom_container.dart';

import '../widgets/image.dart';
import 'my_patient.dart';

class DoctorHomepage extends StatelessWidget {
  const DoctorHomepage({super.key});

  static const id = 'DoctorHomepage';

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: CustomContainer(
        child:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          //image
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 170,
              child: ImagePage(),
            ),
          ),

          //container
          SliverToBoxAdapter(
              child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Mypatients.id, arguments: email);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 100, right: 30, left: 30),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(81, 185, 181, 181),
                  borderRadius: BorderRadius.circular(30)),
              height: 123,
              width: 359,
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "My Patients",
                      style: TextStyle(
                        color: Color(0xFF3C365F),
                        fontSize: 22,
                      ),
                    ),
                    Image(image: AssetImage("assets/images/do.png"))
                  ]),
            ),
          ))
        ]),
      ),
    );
  }
}
