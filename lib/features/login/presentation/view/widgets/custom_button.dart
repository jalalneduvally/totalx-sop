import 'package:flutter/material.dart';
import 'package:totalx/general/utils/color.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({super.key,required this.onPressed,required this.text});

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return  ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(w*0.9, h*0.065),
                  backgroundColor: ColorTheme.secondaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(w*0.08),
                  ),
                ),
                child:  Text(text,
                    style: TextStyle(color: ColorTheme.primaryColor,
                        fontSize: w*0.045,
                        fontWeight: FontWeight.bold)),
              );
  }
}