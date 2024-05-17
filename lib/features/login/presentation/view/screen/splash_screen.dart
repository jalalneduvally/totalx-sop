import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totalx/features/home/presentation/view/screen/home_screen.dart';
import 'package:totalx/features/login/presentation/view/screen/phone_screen.dart';
import 'package:totalx/general/utils/color.dart';
import 'package:totalx/general/utils/image.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  checkUser()async{
    await Future.delayed(const Duration(seconds: 3));
    if(FirebaseAuth.instance.currentUser != null){
      log(FirebaseAuth.instance.currentUser!.phoneNumber.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
   }else{
    Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const PhoneScreen()),
          (route) => false,
        );
   }
  }

  @override
void initState() {
   checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:ColorTheme.primaryColor,
      body: Center(
        child: CircleAvatar(
          radius: w*0.25,
          backgroundImage: const AssetImage(ImagePicture.totalxicon),
        ),
      ),
    );
  }
}