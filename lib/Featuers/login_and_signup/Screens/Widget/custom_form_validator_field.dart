import 'package:flutter/material.dart';
import 'package:health_care/const.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    this.hint,
    this.prefexIcon,
    this.sufxIcon,
    this.onChange,
    this.obSecureText = false,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.initialValue,
    this.controller,
  });

  final String? hint;
  final Icon? prefexIcon;
  final IconButton? sufxIcon;
  final Function(String)? onChange;
  final bool? obSecureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final String? initialValue;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly!,
        controller: controller,
        obscureText: obSecureText!,
        // ignore: body_might_complete_normally_nullable
        validator: validator,
        cursorColor: kprimaryDarkcolor,
        keyboardType: keyboardType,
        onChanged: onChange,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffE7EFF2),
          hintText: hint,
          prefixIcon: prefexIcon,
          prefixIconColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.focused)
                  ? kprimaryDarkcolor
                  : Colors.grey.shade700),
          suffixIcon: sufxIcon,
          suffixIconColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.focused)
                  ? kprimaryDarkcolor
                  : Colors.grey.shade700),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
                color: kprimaryDarkcolor, style: BorderStyle.solid, width: 2),
          ),
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
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
