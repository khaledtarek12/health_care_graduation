import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    this.hint,
    this.prefexIcon,
    this.sufxIcon,
    this.onChange,
    this.obSecureText = false,
    this.keyboardType, this.validator,
  });

  final String? hint;
  final Icon? prefexIcon;
  final IconButton? sufxIcon;
  final Function(String)? onChange;
  final bool? obSecureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        obscureText: obSecureText!,
        // ignore: body_might_complete_normally_nullable
        validator: validator,

        keyboardType: keyboardType,
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
      ),
    );
  }
}
