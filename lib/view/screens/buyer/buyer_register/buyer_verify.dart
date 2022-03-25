import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'controller.dart';

TextEditingController otpCtrl = TextEditingController();
int timeRemain = 45;

dynamic prevScreen;

class BuyerVerify extends StatefulWidget {
  const BuyerVerify({Key? key}) : super(key: key);

  @override
  _BuyerVerifyState createState() => _BuyerVerifyState();
}

class _BuyerVerifyState extends State<BuyerVerify> {
  @override
  Widget build(BuildContext context) {
    prevScreen = ModalRoute.of(context)?.settings.arguments;
    PP.p(prevScreen["contactNo"]);
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
                      "Confirm your phone number", 18, ConstantColors.blueTextColor,
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
                  TextInputController.sixDigitOTPCtrl(context, "OTP", otpCtrl),
                  const SizedBox(
                    height: 20,
                  ),
                  resendOTPCounter(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    height: 48,
                    child: ButtonHelper.getElevatedButton("Verify OTP", () {verify();}),
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

  void verify() {
    BuyerRegisterController buyerRegisterController =  BuyerRegisterController();
    buyerRegisterController.verifyPhoneNumber( context ,prevScreen, otpCtrl.text);
  }
}
