import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_login/logincontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

TextEditingController phoneCtrl = TextEditingController();

class FarmerLoginScreen extends StatelessWidget {
  const FarmerLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarHelper.getSimpleAppBar(name: "Login" , context: context),
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 500),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 250,
              ),
              appDesWid(context),
              const SizedBox(
                height: 20,
              ),
              TextInputController.phoneInputCtrl(
                  context, "Phone Number", phoneCtrl),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 20, bottom: 30),
                height: 48,
                child: ButtonHelper.getElevatedButton("Log In", () => logIn(context)),
              ),
              Divider(
                color: ConstantColors.greyColor,
                thickness: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                      child: TextHelper.textWithColorSize(
                          "Don’t have an account?",
                          15,
                          ConstantColors.blueTextColor,
                          fontWeight: FontWeight.w400)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context , RoutePaths.registerFarmer),
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: TextHelper.textWithColorSize(
                            "Sign up", 15, ConstantColors.mPrimaryColor,
                            fontWeight: FontWeight.w400)),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ));
  }





void logIn(BuildContext context) {
    if(phoneCtrl.text.length == 10){
      LoginController loginController = LoginController();
      try{
        loginController.sendOTPAndLogin(phoneCtrl.text, context);
      }catch (e){
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Valid Number")));
    }
  }
}












Widget appDesWid(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 4),
            child: TextHelper.textWithColorSize(
                "Welcome", 18, ConstantColors.blueTextColor,
                fontWeight: FontWeight.w600)),
        Container(
            margin: const EdgeInsets.only(left: 4, top: 12),
            child: TextHelper.textWithColorSize(
                "Farmer Log in", 18, ConstantColors.blueTextColor,
                fontWeight: FontWeight.w500)),
      ],
    ),
  );
}
