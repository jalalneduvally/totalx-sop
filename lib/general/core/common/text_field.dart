import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  int? maxLength;
  TextInputType? type;
   TextFieldCustom({super.key,required this.controller,
   required this.validator,required this.hintText,this.maxLength,this.type});

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
         return TextFormField(
                controller: controller,
                keyboardType: type,
                maxLength: maxLength,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validator,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: w*0.03,bottom: h*0.01),
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.02),
                    )
                ),
              );
  }
}