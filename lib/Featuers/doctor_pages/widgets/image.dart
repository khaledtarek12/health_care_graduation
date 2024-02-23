//import 'dart:ffi';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../views/bigimg.dart';


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
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Bigimg();
                }));
              },
              child: imag == null
                  ? const CircleAvatar(
                      backgroundColor: Color.fromARGB(81, 103, 93, 93),
                      backgroundImage: AssetImage(
                          "assets/images/emptyprofile.jpeg"), //imag == null ? Image.asset("assets/emptyprofile.jpeg") : FileImage(imag!),
                      maxRadius: 95,
                    )
                  : CircleAvatar(
                      backgroundColor: const Color.fromARGB(81, 103, 93, 93),
                      backgroundImage: FileImage(imag!),
                      maxRadius: 95,
                    )),
          ElevatedButton(
            onPressed: () {
              pickImage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff7296A8),
              shape: const CircleBorder(),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imag = File(pickedFile.path);
      });
    }
  }
}
