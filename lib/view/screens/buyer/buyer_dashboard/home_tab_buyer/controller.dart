import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/buy_crop_data.dart';
import 'data/demand_crop_data.dart';

class HomeScreenController {
  static Future<List<CropBuyDataBuyer>> fetchDataForSell(
      BuildContext context) async {
    try {
      List<CropBuyDataBuyer> mReturnVal = [];

      await FirebaseFirestore.instance
          .collection("crops")
          .get()
          .then((element) {
        for (var element in element.docs) {
          mReturnVal.add(CropBuyDataBuyer.fromJson(element.data()));
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

  static Future<List<CropDemandDataBuyer>> fetchDataForDemand(
      BuildContext context) async {
    try {
      List<CropDemandDataBuyer> mReturnVal = [];

      await FirebaseFirestore.instance
          .collection("demands")
          .get()
          .then((element) {
        for (var element in element.docs) {
          mReturnVal.add(CropDemandDataBuyer.fromJson(element.data()));
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
