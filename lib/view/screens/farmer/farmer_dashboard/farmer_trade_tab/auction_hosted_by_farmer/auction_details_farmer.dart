import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/current_farmer/current_user.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_trade_tab/auction_hosted_by_farmer/data/auction_data.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_trade_tab/data/farmer_auction_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card/demandcard.dart';


class AuctionDetails extends StatefulWidget {
  final String auctionID;
  final FarmerAuctionData data;

  const AuctionDetails({Key? key, required this.auctionID, required this.data}) : super(key: key);

  @override
  _AuctionDetailsState createState() => _AuctionDetailsState();
}

class _AuctionDetailsState extends State<AuctionDetails> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.whiteBackground,
      appBar: AppBarHelper.getSimpleAppBar(
          context: context, name: "Auction details"),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          child: Container(
              alignment: Alignment.topCenter,
              constraints: const BoxConstraints(maxWidth: 500),
              margin: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  topDemandCard(widget.data),
                  FutureBuilder<List<AuctionFullDataFarmer>>(
                    future: fetchData(context , widget.auctionID),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<AuctionFullDataFarmer>? data = snapshot.data;
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DemandCardByBuyerForAuction(
                                  data: data[index],
                                  auctionID : widget.auctionID
                              );
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
                  )
                ],
              )),
        ),
      )
    );
  }
  static Future<List<AuctionFullDataFarmer>> fetchData(BuildContext context , String auction) async {
    try {
      List<AuctionFullDataFarmer> mReturnVal = [];

      await FirebaseFirestore.instance
          .collection("farmers")
          .doc(CurrentFarmerUser.farmerID)
          .collection("auctions")
          .doc(auction)
          .collection("bids")
          .get()
          .then((element) {
        for (var element in element.docs) {
          mReturnVal.add(AuctionFullDataFarmer.fromJson(element.data()));
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

  topDemandCard(FarmerAuctionData farmerAuctionData) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper.textWithColorSize("Your Phone :  " + farmerAuctionData.auctionID.substring(0 , 13) , 15 , Colors.blue , fontWeight: FontWeight.w400),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: ConstantColors.mPrimaryColor,borderRadius: const BorderRadius.all(Radius.circular(5))),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),

                      child:TextHelper.textWithColorSize("LIVE" , 8 , Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
          TextHelper.textWithColorSize("Your Name :  " + farmerAuctionData.farmerName , 15 , Colors.blue , fontWeight: FontWeight.w400),
          const SizedBox(height: 5,),
          TextHelper.textWithColorSize(farmerAuctionData.cropName , 16 , Colors.green ,fontWeight: FontWeight.w500),
          const SizedBox(height: 5,),
          TextHelper.textWithColorSize("Offer per unit :  "+   farmerAuctionData.offerperUnit.toString() + " Rs", 15 , Colors.black),
          const SizedBox(height: 5,),
          TextHelper.textWithColorSize("Minimum Quantity:  " + farmerAuctionData.minimumQuantity.toString()+" Kg", 15, Colors.black),
          const SizedBox(height: 5,),
          TextHelper.textWithColorSize("Available Quantity:  " + farmerAuctionData.totalQuantity.toString()+" Kg", 15, Colors.black),
          const SizedBox(height: 5,),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child:TextHelper.textWithColorSize(
                "Address : ${farmerAuctionData.village}, ${farmerAuctionData.district}, ${farmerAuctionData.state}", 15 , Colors.black),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                farmerAuctionData.transport?
                TextHelper.textWithColorSize("Transportation Available", 15, Colors.green):
                TextHelper.textWithColorSize("Transportation Not Available", 15, Colors.black),

                Row(
                  children: [
                    TextHelper.textWithColorSize("Auction", 14, Colors.blue , fontWeight: FontWeight.w500)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}