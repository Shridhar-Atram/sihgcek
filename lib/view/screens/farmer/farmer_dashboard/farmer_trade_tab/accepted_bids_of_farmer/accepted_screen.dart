import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:e_agri_farmers/helper/circularloader.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/current_farmer/current_user.dart';
import 'package:flutter/material.dart';

import 'accepted_bid_card.dart';
import 'accepted_bid_screen_data.dart';

class AcceptedBidScreen extends StatelessWidget {

  const AcceptedBidScreen({Key? key}) : super(key: key);

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
    return FutureBuilder<List<AcceptedBidScreenData>>(
      future: getListData(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AcceptedBidScreenData>? data = snapshot.data;
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return AcceptedBidCard(data: data[index],);
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default show a loading spinner.
        return Center(
          child: MLoader.mLoader(40),
        );
      },
    );
  }

  Future<List<AcceptedBidScreenData>> getListData(BuildContext context) async {
    try {
      List<AcceptedBidScreenData> mReturnVal = [];

      await FirebaseFirestore.instance
          .collection("farmers")
          .doc(CurrentFarmerUser.farmerID)
          .collection("my_previous_bids")
          .get()
          .then((element) {
        for (var element in element.docs) {
          mReturnVal.add(AcceptedBidScreenData.fromJson(element.data()));
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
