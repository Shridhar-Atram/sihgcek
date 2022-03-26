

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/schemes/shemadata.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/techniques/techdata.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/tools/tooldata.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';



class FerScreen extends StatefulWidget {
  const FerScreen({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<FerScreen> {
  @override
  Widget build(BuildContext context) {

    // print();
    var data =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String val = data["data"]["result"];
    val = val[0].toUpperCase() + val.substring(1);
    // print(sd.docs);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("scheme"),
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  child: TextHelper.textWithColorSize("Recommended Fertilizer is ", 20, Colors.black , fontWeight: FontWeight.w400),
                ),
                Container(
                  child: TextHelper.textWithColorSize(val, 30, ConstantColors.mPrimaryColor , fontWeight: FontWeight.w500),
                ),
              ],
            )
        ),
      ),
    );
  }
}

