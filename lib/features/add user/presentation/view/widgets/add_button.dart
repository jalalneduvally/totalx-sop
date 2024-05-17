import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function() onTap;
  final String test;
  final Color color;
  const AddButton({super.key, required this.onTap, required this.test, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
                      onTap: onTap,
                      child: Container(
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  Center(child: Text(test,
                        style:const TextStyle(
                          color: Colors.white,
                        ),),),
                      ),
                    );
  }
}