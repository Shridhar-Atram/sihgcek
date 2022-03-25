import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/utils/LocalStorage/shared_preferences.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/current_farmer/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FarmerRegisterController{
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
            context, RoutePaths.verifyFarmer,
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
              context, RoutePaths.verifyFarmer,
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
          var res = await registerFarmerToFirebase(
              name: data["name"],
              aadharCard: data["adhaarCard"],
              contactNo: "+91"+ data["contactNo"],
              emailId: data["emailId"],
              address: data["address"],
              password: data["password"], shopName: data["shopName"]);
              PP.p("res is " + res.toString());
          if(res == "done"){
            await UserPreferences.setFarmerID("+91" + data["contactNo"]);
            CurrentFarmerUser.farmerID = "+91" + data["contactNo"];
            CurrentFarmerUser.address = data["address"];
            CurrentFarmerUser.name = data["name"];
            CurrentFarmerUser.shopName = data["shopName"];
            CurrentFarmerUser.emailID = data["emailId"];
            CurrentFarmerUser.contactNo = "+91" +  data["contactNo"];
            EasyLoading.dismiss();
            Navigator.of(context).pushNamedAndRemoveUntil(
                RoutePaths.farmerDashboardController,
                    (Route<dynamic> route) => false);
          }else{

            EasyLoading.dismiss();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something Went Wrong")));
          }
        }catch(e){
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }
  }
}