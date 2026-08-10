import 'package:flutter/material.dart';

import '../utilis/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onPressed,
    this.color = const Color(0xFFFF9800),
    this.width = double.infinity,this.textStyle });

  final String text;
  final void Function()? onPressed;
  final Color color;
  final double? width;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(text, style: textStyle ?? Styles.style18),
      ),
    );
  }
}