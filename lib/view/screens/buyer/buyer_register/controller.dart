
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/utils/LocalStorage/shared_preferences.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/current_logged_buyer/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BuyerRegisterController{
  Future<void> sendOTPAndRegister(var data , BuildContext context) async {
    EasyLoading.show(status:  "Sending OTP",dismissOnTap: false,);
    if (kIsWeb) {
      late String vid;
      try {
        ConfirmationResult confirmationResult = await FirebaseAuth.instance.signInWithPhoneNumber(
            "+91"+data["contactNo"]);
        vid = confirmationResult.verificationId;
        EasyLoading.dismiss();
        data["vid"] = vid;
        Navigator.pushNamed(
            context, RoutePaths.verifyBuyer,
            arguments: data
        );
      } catch(e) {
        EasyLoading.showToast(e.toString(),
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + data["contactNo"],
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
          data["vid"] = verificationId;
          Navigator.pushNamed(
              context, RoutePaths.verifyBuyer,
              arguments: data
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          EasyLoading.dismiss();
        },
      );
    }
  }

  Future<void>  verifyPhoneNumber(BuildContext context, var data, String otp) async {
     EasyLoading.show(status:  "Verifying", dismissOnTap: false,);
    if (otp.length < 6) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter valid OTP"),));
    } else {
      PhoneAuthCredential phoneAuthCredential =
      PhoneAuthProvider.credential(verificationId: data["vid"], smsCode: otp);
      UserCredential? user;
      try {
        user = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      } catch (e) {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter valid OTP"),));
      }
      if (user != null) {
        try{
          var res = await registerBuyerToFirebase(
              name: data["name"],
              aadharCard: data["adhaarCard"],
              contactNo: "+91"+ data["contactNo"],
              emailId: data["emailId"],
              role: data["role"],
              address: data["address"],
              panNo: data["panNo"],
              gstNo: data["gstNo"],
              compnyName: data["companyName"],
              password: data["password"]);
          PP.p("res is " + res.toString());
          if(res == "done"){
            await UserPreferences.setBuyerID("+91" + data["contactNo"]);
            CurrentBuyerUser.buyerID = "+91" + data["contactNo"];
            CurrentBuyerUser.role = data["role"];
            CurrentBuyerUser.address = data["address"];
            CurrentBuyerUser.panNo = data["panNo"];
            CurrentBuyerUser.companyName = data["companyName"];
            CurrentBuyerUser.name = data["name"];
            CurrentBuyerUser.gstNo = data["gstNo"];
            CurrentBuyerUser.emailID = data["emailId"];
            CurrentBuyerUser.adhaarCardNo = data["adhaarCard"];
            CurrentBuyerUser.contactNo = "+91"+ data["contactNo"];
            EasyLoading.dismiss();
            Navigator.of(context).pushNamedAndRemoveUntil(
                RoutePaths.buyerDashboardController,
                    (Route<dynamic> route) => false);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something Went Wrong")));
          }
        }catch(e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("register " + e.toString())));
        }
      }
    }
  }
}