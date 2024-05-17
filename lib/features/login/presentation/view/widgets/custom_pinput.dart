import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:totalx/general/utils/color.dart';

class CustomPinput extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final double w;
  final double h;
  const CustomPinput(
      {super.key,
      required this.onChanged,
      required this.validator,
      required this.w,
      required this.h});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.035, right: w * 0.035),
      child: Pinput(
        // focusedPinTheme:PinTheme(
        //   height: h * 0.05,
        //   width: w,
        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(w * 0.03), border: Border.all(color: Colors.black)),
        // ),
        followingPinTheme: PinTheme(
          height: h * 0.05,
          width: w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(w * 0.03),
              border: Border.all(color: ColorTheme.secondaryColor)),
        ),
        validator: validator,
        onChanged: onChanged,
        length: 6,
      ),
    );
  }
}
