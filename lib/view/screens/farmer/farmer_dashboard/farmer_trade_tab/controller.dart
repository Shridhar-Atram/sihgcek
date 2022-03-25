import 'dart:convert';
import 'dart:io';

import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/current_farmer/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/farmer_auction_data.dart';
import 'data/recent_bid_data.dart';

class TradScreenController{
  static Future<List<dynamic>> fetchTradeScreenData(BuildContext context) async {
    try {
      final response = await tradeScreenFarmer(farmerID: CurrentFarmerUser.farmerID);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<dynamic> mReturnVal = [];


        List<FarmerAuctionData> farmerAuctionData = [];
        List<RecentBidDataFarmer> farmerRecendBidData = [];

        int acceptedBid = jsonResponse["acceptedBid"];
        int acceptedAuction = jsonResponse["acceptedAuction"];

        jsonResponse['farmerAuction'].map((element) {
          try {
            farmerAuctionData.add(FarmerAuctionData.fromJson(element));
          } catch (E) {
            PP.p(E.toString());
          }
        }).toList();

        jsonResponse['recentBids'].map((element) {
          try {
            farmerRecendBidData.add(RecentBidDataFarmer.fromJson(element));
          } catch (E) {
            PP.p(E.toString());
          }
        }).toList();

        mReturnVal.add(acceptedBid);
        mReturnVal.add(acceptedAuction);
        mReturnVal.add(farmerAuctionData);
        mReturnVal.add(farmerRecendBidData);

        return mReturnVal;
      }
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
