//import 'dart:ffi';

import 'dart:io';

import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ImagePage> {
  File? imag;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: hight,
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/doctor.png'),
        ),
      ),
    );
  }
}
