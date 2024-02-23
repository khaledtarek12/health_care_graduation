import 'package:flutter/material.dart';

class Bigimg extends StatelessWidget {
  const Bigimg({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF3C365F),
              ) //Icon(Icons.arrow_back,
              ),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: width,
            height: hight * (3 / 5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/patient.jpeg'), fit: BoxFit.fill),
              // borderRadius: BorderRadius.circular(360),
            ),
          ),
        ));
  }
}
