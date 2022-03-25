
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/utils/LocalStorage/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginController {
  Future<bool> getUserResponse(String phone) async {
    PP.p("phone");
    bool res = await loginBuyerToFirebase(
      contactNo: "+91" + phone,
    );
    return res;
  }

  Future<void> sendOTPAndLogin(String phoneNum, BuildContext context) async {
    EasyLoading.show(
      status: "Sending OTP",
      dismissOnTap: false,
    );


    try {
      bool userPresent = await getUserResponse(phoneNum);
      if (!userPresent) {
        EasyLoading.showError("User Not Found!");
        return;
      }
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return;
    }

    if (kIsWeb) {
      //if Platform is Web
      late String vid;
      try {
        ConfirmationResult confirmationResult =
            await FirebaseAuth.instance.signInWithPhoneNumber("+91" + phoneNum);
        vid = confirmationResult.verificationId;
        EasyLoading.dismiss();
        Navigator.pushNamed(context, RoutePaths.verifyBuyerLogin, arguments: {
          "vid": vid,
          "buyerID": phoneNum,
          "resendToken": "resendToken",
          "phone": "+91" + phoneNum
        });
      } catch (e) {
        EasyLoading.showToast(e.toString(),
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      //mobile Login
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + phoneNum,
        verificationCompleted: (PhoneAuthCredential credential) {
          EasyLoading.dismiss();
        },
        verificationFailed: (FirebaseAuthException e) {
          EasyLoading.dismiss();
          final snackBar = SnackBar(
            content: Text(e.toString()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verificationId, int? resendToken) {
          EasyLoading.dismiss();
          Navigator.pushNamed(context, RoutePaths.verifyBuyerLogin, arguments: {
            "vid": verificationId,
            "buyerID": phoneNum,
            "resendToken": resendToken,
            "phone": "+91" + phoneNum
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          EasyLoading.dismiss();
        },
      );
    }
  }



  Future<void> verifyPhoneNumber(BuildContext context, String? vid, String otp,
      String phone, String buyerId) async {
    //verify Phone number
    PP.p("buyerId---->" + buyerId);
    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter valid OTP"),
      ));
    } else {
      PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(verificationId: vid!, smsCode: otp);
      UserCredential? user;
      try {
        user = await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential);
      } catch (e) {
        PP.p(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Wrong OTP"),
        ));
      }
      if (user != null) {
        try {
            if(await getAndSaveLoginDataBuyer(contactNo: phone)){
              await UserPreferences.setBuyerID(phone);
              EasyLoading.dismiss();
              PP.p("Done Login");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutePaths.buyerDashboardController, (Route<dynamic> route) => false);
            }else{
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("User Data Not Found")));
            }
          } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }
  }
}
