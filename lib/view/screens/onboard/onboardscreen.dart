import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/constants/lmagepaths/logopaths.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                top: 200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [logoWidget(), appDesWid(), loginSignUpWid(context)],
              ),
            ),
          ),
        )
    );
  }
}

Widget logoWidget() {
  return Image.asset(LogoPaths.onBoarScreenLogo);
}

Widget appDesWid() {
  return Container(
    margin: const EdgeInsets.only(top: 20, left: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.home, color: ConstantColors.mPrimaryColor),
            Container(
                margin: const EdgeInsets.only(left: 4),
                child: TextHelper.textWithColorSize(
                    "Welcome", 18, ConstantColors.blueTextColor,
                    fontWeight: FontWeight.w600))
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 4, top: 12),
            child: TextHelper.textWithColorSize(
                "Welcome to E-Agri \nMobile App",
                18,
                ConstantColors.blueTextColor,
                fontWeight: FontWeight.w500)),
        Container(
            margin: const EdgeInsets.only(left: 4, top: 12),
            child: TextHelper.textWithColorSize("Easily sell your crops and produce",
                18, ConstantColors.blueTextColor)),
      ],
    ),
  );
}

Widget loginSignUpWid(BuildContext context) {
  return Column(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
        height: 48,
        child: ButtonHelper.getElevatedButton("On Board", () {Navigator.pushNamed(context, RoutePaths.chooseType);}),
      ),
    ],
  );
}
