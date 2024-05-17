import 'dart:async';
import 'package:flutter/material.dart';
import 'package:totalx/features/home/presentation/view/screen/home_screen.dart';
import 'package:totalx/features/login/presentation/view/screen/otp_verification.dart';
import 'package:totalx/features/login/presentation/view/screen/phone_screen.dart';
import 'package:totalx/features/login/repo/auth_repository.dart';
import 'package:totalx/general/services/show_message.dart';


class AuthController extends ChangeNotifier{

  AuthRepository  authRepository = AuthRepository();
TextEditingController phoneController=TextEditingController();
  Timer? timer;
  int countDown=59;
  bool canResend=false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown > 0) {
        countDown=countDown-1;
      } else {
        canResend=true;
        timer.cancel();
      }
      notifyListeners();
    });
  }

   void resendOtp() {
    if (canResend) {
      countDown= 59;
      canResend= false;
      startTimer();
    }
  }


  void phoneSignIn({
    required BuildContext context,
  }) async {
    final user = await authRepository.phoneSignIn("+91${phoneController.text.trim()}");
    user.fold((l) => showMessage(l.toString(), Colors.red),
        (r) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              phoneNumber:"+91${phoneController.text.trim()}",
            ),
          ));
    });
  }

  void verifyOtp({
    required BuildContext context,
    required String code,
  }) async {
    final user = await authRepository.verifyOtp(code);
    user.fold((l) => showMessage(l.toString(), Colors.red),
        (r) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
          showMessage("Login Successfully..!", Colors.green);
    });
  }

  Future<void> logout(BuildContext context) async {
    await authRepository.logout(
        failure: (msg) {
           showMessage(msg.toString(), Colors.red);
        },
        success: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const PhoneScreen(),
            ),
            (route) => false,
          );
        });
  }
}
