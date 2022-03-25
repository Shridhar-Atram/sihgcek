import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/demand_crop_data.dart';
import 'data/sell_crop_data.dart';



class HomeScreenController {
  static Future<List<SellCropDataFarmer>> fetchDataForSell(BuildContext context) async {
    try {
        List<SellCropDataFarmer> mReturnVal = [];

        await FirebaseFirestore.instance
            .collection("crops")
            .get()
            .then((element)  {
          element.docs.forEach((element) {
            mReturnVal.add(SellCropDataFarmer.fromJson(element.data()));
          });
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
  static Future<List<DemandCropDataFarmer>> fetchDataForDemand(BuildContext context) async {
    try {

        List<DemandCropDataFarmer> mReturnVal = [];

        await FirebaseFirestore.instance
            .collection("demands")
            .get()
            .then((element)  {
          element.docs.forEach((element) {
            mReturnVal.add(DemandCropDataFarmer.fromJson(element.data()));
          });
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
