import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChooseType extends StatelessWidget {
  const ChooseType({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   child: Container(
                  //     margin: const EdgeInsets.all(30,),
                  //     alignment: Alignment.centerLeft,
                  //     child: const Icon(Icons.translate,size: 30,color: Colors.black,),
                  //   ),
                  //   onTap:() => LangDialog.showLangDialog(context),
                  // ),
                  const SizedBox(height: 200,),
                  appDesWid(context),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 60 , bottom: 30),
                    height: 48,
                    child: ButtonHelper.getElevatedButton("I am a Farmer", ()=>Navigator.pushNamed(context, RoutePaths.loginFarmer)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: ConstantColors.blueTextColor,
                      thickness: 1,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
                    height: 48,
                    child: ButtonHelper.getElevatedButton("I am a Trader / Mill / Exporter", ()=>Navigator.pushNamed(context, RoutePaths.loginBuyer)),
                  ),
                  const SizedBox(height: 70,),
                  // loginSignUpWid(context),
                  const SizedBox(height: 70,),
                ],
              )
          ),
        ),
      )
    );
  }


}

Widget appDesWid(BuildContext context) {
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
                "Please select one option",
                18,
                ConstantColors.blueTextColor,
                fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

// Widget loginSignUpWid(BuildContext context) {
//   return Column(
//     children: [
//       Container(
//         margin: const EdgeInsets.only(left: 4, top: 30),
//         child: TextHelper.textWithColorSize(
//             "Already have an account?", 18, ConstantColors.blueTextColor),
//       ),
//       TextButton(
//         onPressed: (){Navigator.pushNamed(context, RoutePaths.login);},
//         child: TextHelper.textWithColorSize(
//             "Log In Here", 18, ConstantColors.mPrimaryColor),
//       ),
//     ],
//   );
// }

