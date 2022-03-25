import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/utils/LocalStorage/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.whiteBackground,
      appBar: AppBarHelper.getSimpleAppBar(context: context, name: "Settings"),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: TextHelper.textWithColorSize("Contact : +91**********", 18, Colors.black , fontWeight: FontWeight.w500),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                  UserPreferences.clearData();
                  Navigator.pushNamedAndRemoveUntil(context, RoutePaths.onBoardScreen , (route) => false);
                },
                child: TextHelper.textWithColorSize("Sign Out",
                    18, Colors.white , fontWeight: FontWeight.w700),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.red)),
              ),
            )
          ],
        ),
      )
    );
  }
}
