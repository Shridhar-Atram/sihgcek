import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/utils/LocalStorage/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future<void> initializeFirebase(BuildContext context) async {
    // await Future.delayed(const Duration(milliseconds: 1950), () {});
    try {
      await Firebase.initializeApp().then((value) {
        doneInitializing(context);
      });
    } catch (e) {
      PP.p(e.toString());
    }
  }

  Future<void> doneInitializing(BuildContext context) async {
    await UserPreferences.init();
    if (UserPreferences.getBuyerID() != null &&
        UserPreferences.getBuyerID() != "" &&
        FirebaseAuth.instance.currentUser != null &&
        await getAndSaveLoginDataBuyer(
        contactNo: UserPreferences.getBuyerID().toString())) {
      PP.p("buyer Login---->" + UserPreferences.getBuyerID().toString());
      // CurrentBuyerUser.buyerID = UserPreferences.getBuyerID()!;
      Navigator.pushNamedAndRemoveUntil(context, RoutePaths.buyerDashboardController , (Route<dynamic> route) => false);

    } else if (UserPreferences.getFarmerID() != null &&
        UserPreferences.getFarmerID() != "" &&
        FirebaseAuth.instance.currentUser != null &&
        await getAndSaveLoginDataFarmer(
            contactNo: UserPreferences.getFarmerID().toString())) {
      PP.p("farmer Login---->" + UserPreferences.getFarmerID().toString());
      // CurrentFarmerUser.farmerID = UserPreferences.getFarmerID()!;
      Navigator.pushNamedAndRemoveUntil(context, RoutePaths.farmerDashboardController ,(Route<dynamic> route) => false);
    } else {
      FirebaseAuth.instance.signOut();
      UserPreferences.clearData();
      Navigator.pushReplacementNamed(context, RoutePaths.onBoardScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeFirebase(context);
    return Scaffold(
        backgroundColor: ConstantColors.mPrimaryColor,
        body: Center(
            child: TextHelper.textWithColorSize("E-Agri", 18, Colors.white,
                fontWeight: FontWeight.w600)));
  }
}
