import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.prefexIcon,
    this.sufxIcon,
    this.onChange,
    this.onSubmitted,
    this.controller,
    this.obSecureText = false,
  });

  final String? hint;
  final Icon? prefexIcon;
  final Icon? sufxIcon;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final bool? obSecureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obSecureText!,
      controller: controller,
      onSubmitted: onSubmitted,
      onChanged: onChange,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffE7EFF2),
        hintText: hint,
        prefixIcon: prefexIcon,
        suffixIcon: sufxIcon,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
