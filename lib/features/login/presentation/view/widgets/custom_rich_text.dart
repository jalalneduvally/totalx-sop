import 'package:flutter/material.dart';
import 'package:totalx/general/utils/color.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final List<TextSpan> list;
  const CustomRichText({super.key, required this.text, required this.list});

  @override
  Widget build(BuildContext context) {
    return  RichText(
                text:  TextSpan(
                  text: text,
                  style: const TextStyle(
                    color: ColorTheme.secondaryColor
                  ),
                  children: list,
                ),
              );
  }
}