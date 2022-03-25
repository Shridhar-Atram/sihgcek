import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/current_logged_buyer/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'accepted_bid_card.dart';
import 'accepted_bid_screen_data.dart';

class AcceptedBidScreenBuyer extends StatelessWidget {

  const AcceptedBidScreenBuyer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.whiteBackground,
      appBar: AppBarHelper.getSimpleAppBar(context: context, name: "My Purchases"),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            margin: const EdgeInsets.only(top: 20),
            child: getList(context),
          ),
        ),
      )
    );
  }

  getList(BuildContext context){
    return FutureBuilder<List<AcceptedBidBuyerData>>(
      future: getListData(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AcceptedBidBuyerData>? data = snapshot.data;
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return AcceptedBidCardBuyer(data: data[index]);
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default show a loading spinner.
        return Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            backgroundColor: ConstantColors.mPrimaryColor,
          ),
        );
      },
    );
  }

  Future<List<AcceptedBidBuyerData>> getListData(BuildContext context) async {
    try {
      List<AcceptedBidBuyerData> mReturnVal = [];

      await FirebaseFirestore.instance
          .collection("buyers")
          .doc(CurrentBuyerUser.buyerID)
          .collection("my_previous_bids")
          .get()
          .then((element) {
        for (var element in element.docs) {
          mReturnVal.add(AcceptedBidBuyerData.fromJson(element.data()));
        }
      });

      return mReturnVal;
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No internet Connection"),
      ));
    } catch (e) {
      PP.p("home screen controller error ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something Went Wrong"),
      ));
    }
    return [];
  }
}
