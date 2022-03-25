import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_login/logincontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:timer_count_down/timer_count_down.dart';

TextEditingController optCtrl = TextEditingController();
int timeRemain = 45;
LoginController loginController = LoginController();
Map<String, dynamic>? prevVal;

class VerifyBuyerLogin extends StatefulWidget {
  const VerifyBuyerLogin({Key? key}) : super(key: key);

  @override
  _VerifyBuyerLoginState createState() => _VerifyBuyerLoginState();
}

class _VerifyBuyerLoginState extends State<VerifyBuyerLogin> {
  @override
  Widget build(BuildContext context) {
    prevVal = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>?;
    return Scaffold(
        appBar: AppBarHelper.getSimpleAppBar(name: "verify" , context: context),

        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Center(
            child: Container(
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(maxWidth: 500),
              margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextHelper.textWithColorSize(
                      "Confirm your phone number", 18,
                      ConstantColors.blueTextColor,
                      fontWeight: FontWeight.w400),
                  const SizedBox(
                    height: 40,
                  ),
                  TextHelper.textWithColorSize(
                      "Enter OTP", 18, ConstantColors.blueTextColor,
                      fontWeight: FontWeight.w500),
                  const SizedBox(
                    height: 30,
                  ),
                  TextInputController.sixDigitOTPCtrl(context, "OTP", optCtrl),
                  const SizedBox(
                    height: 20,
                  ),
                  resendOTPCounter(),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    height: 48,
                    child: ButtonHelper.getElevatedButton("Verify OTP", () {
                      loginController.verifyPhoneNumber(
                          context, prevVal!["vid"], optCtrl.text,prevVal!["phone"] , prevVal!["buyerID"]);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  resendOTPCounter() {
    return Row(
      children: [
        TextButton(
            onPressed: timeRemain == 0
                ? () {
              setState(() {
                resendOTP(context, prevVal!["phone"], prevVal!["resendToken"]);
                timeRemain = 45;
              });
            }
                : null,
            child: Text(
              "Resend OTP",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: timeRemain == 0 ? Colors.blue : Colors.grey),
            )),
        Countdown(
          seconds: timeRemain,
          build: (BuildContext context, double time) =>
              Text("0 : " + (time.toInt()).toString()),
          interval: const Duration(seconds: 1),
          onFinished: () {
            setState(() {
              timeRemain = 0;
            });
          },
        )
      ],
    );
  }
}


void resendOTP(BuildContext context, String phone, int? resendToken) {
  EasyLoading.show(status: "Sending OTP");
  FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phone,
    verificationCompleted: (PhoneAuthCredential credential) {
      EasyLoading.dismiss();
    },
    verificationFailed: (FirebaseAuthException e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!),));
      EasyLoading.dismiss();
    },
    codeSent: (String verificationId, int? resendToken) {
      prevVal!["vid"] = verificationId;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP Send"),));
      EasyLoading.dismiss();
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Time Out"),));
      EasyLoading.dismiss();
    },
  );
}

