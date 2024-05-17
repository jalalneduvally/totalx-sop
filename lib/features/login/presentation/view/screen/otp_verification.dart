import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/features/login/presentation/provider/auth_provider.dart';
import 'package:totalx/features/login/presentation/view/widgets/custom_button.dart';
import 'package:totalx/features/login/presentation/view/widgets/custom_pinput.dart';
import 'package:totalx/features/login/presentation/view/widgets/custom_rich_text.dart';
import 'package:totalx/general/utils/color.dart';
import 'package:totalx/general/utils/image.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  var code = '';
  @override
  void initState() {
    context.read<AuthController>().startTimer();
    super.initState();
  }

  @override
  void dispose() {
    context.read<AuthController>().timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final loginProvider = Provider.of<AuthController>(context);

    return PopScope(
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(w * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImagePicture.verifyicon, height: h * 0.15),
                  SizedBox(height: h * 0.03),
                  const Row(
                    children: [
                      Text(
                        "OTP Verification",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.04,
                  ),
                  Text(
                    "Enter the verification code we just sent to your number +91********${widget.phoneNumber.substring(widget.phoneNumber.length - 2)}",
                    style: TextStyle(fontSize: w * 0.04),
                  ),
                  SizedBox(
                    height: h * 0.015,
                  ),
                  CustomPinput(
                      onChanged: (value) {
                        code = value;
                      },
                      validator: (value) {
                        if (value?.length != 6) {
                          return 'Please enter OTP';
                        }
                        return null;
                      },
                      w: w,
                      h: h),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Consumer<AuthController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Text(
                        "${value.countDown.toString()} Sec",
                        style: const TextStyle(color: ColorTheme.redColor),
                      );
                    },
                  ),
                  SizedBox(
                    height: h * 0.015,
                  ),
                  Consumer<AuthController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return CustomRichText(
                          text: 'Don\'t Get OTP? ',
                          list: <TextSpan>[
                            value.canResend
                                ? TextSpan(
                                    text: 'Resend',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        loginProvider.phoneSignIn(
                                            context: context);
                                        loginProvider.resendOtp();
                                      },
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: ColorTheme.blueColor))
                                : const TextSpan(
                                    text: 'Resend',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: ColorTheme.greyColor),
                                  ),
                          ]);
                    },
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginProvider.verifyOtp(context: context, code: code);
                        }
                      },
                      text: "Verify")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
