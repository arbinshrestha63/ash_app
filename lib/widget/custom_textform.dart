import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.hint = "",
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.controller,
  }) : super(key: key);

  final String hint;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(8.0),
        border:
            Border.all(width: 1.0, color: const Color.fromARGB(9, 56, 56, 56)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(48, 0, 0, 0),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 17,
            color: Color(0xff9c9c9c),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
