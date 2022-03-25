import 'dart:convert';
import 'dart:io';

import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/current_logged_buyer/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/buyer_auction_data.dart';
import 'data/recent_bid_data.dart';

class TradScreenController{
  static Future<List<dynamic>> fetchTradeScreenData(BuildContext context) async {
    try {
      final response = await tradeScreenBuyer(buyerID: CurrentBuyerUser.buyerID);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<dynamic> mReturnVal = [];

        List<BuyerAuctionData> buyerAuctionData = [];
        List<RecentBidDataBuyer> buyerRecendBidData = [];


        int acceptedBid = jsonResponse["acceptedBid"];
        int acceptedAuction = jsonResponse["acceptedAuction"];

        jsonResponse['buyerAuction'].map((element) {
          try {
            buyerAuctionData.add(BuyerAuctionData.fromJson(element));
          } catch (E) {
            PP.p(E.toString());
          }
        }).toList();

        jsonResponse['recentBids'].map((element) {
          try {
            buyerRecendBidData.add(RecentBidDataBuyer.fromJson(element));
          } catch (E) {
            PP.p("recentBids-->" + E.toString());
          }
        }).toList();
        mReturnVal.add(acceptedBid);
        mReturnVal.add(acceptedAuction);
        mReturnVal.add(buyerAuctionData);
        mReturnVal.add(buyerRecendBidData);

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
