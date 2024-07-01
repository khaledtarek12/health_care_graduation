import 'package:flutter/material.dart';

class InformationContainerModel {
  final String text;
  final String image;
  final Color color;
  void Function()? onTap;

  InformationContainerModel(
      {required this.text,
      required this.image,
      required this.color,
      this.onTap});
}
