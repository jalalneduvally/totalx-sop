import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/features/login/presentation/provider/auth_provider.dart';
import 'package:totalx/features/login/presentation/view/widgets/custom_button.dart';
import 'package:totalx/features/login/presentation/view/widgets/custom_rich_text.dart';
import 'package:totalx/general/core/common/text_field.dart';
import 'package:totalx/general/utils/color.dart';
import 'package:totalx/general/utils/image.dart';


class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});
  static String verify = "";

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
   final loginProvider=Provider.of<AuthController>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(w*0.03),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagePicture.phoneicon,height: h*0.15,),
              SizedBox(height: h*0.03,),
              const Row(
                children: [
                  Text("Enter Phone Number",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
              SizedBox(height: h*0.01,),
              TextFieldCustom(controller: loginProvider.phoneController,
               validator: (value) {
                  if (value?.length != 10) {
                    return 'Please enter valid No';
                  }
                  return null;
                },
                 hintText: "Enter Phone Number",
                 maxLength: 10,
                 type: TextInputType.number,),
              SizedBox(height: h*0.01,),
             const CustomRichText(text: 'By Continuing, I agree to TotalX\'s',
               list: <TextSpan>[
                    TextSpan(text: ' Terms and condition',
                        style: TextStyle(
                            color: ColorTheme.blueColor
                        )),
                    TextSpan(text: ' & '),
                    TextSpan(text: 'privacy policy',
                        style: TextStyle(
                            color: ColorTheme.blueColor
                        )),
                  ]),
              SizedBox(height: h*0.02,),
              CustomButton(onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    loginProvider.phoneSignIn(context: context);
                  }
                },
                text: "Get OTP")
          ],),
        ),
      ),
    );
  }
}
