

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/schemes/shemadata.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/techniques/techdata.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';



class TechDetailScreen extends StatefulWidget {
  const TechDetailScreen({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<TechDetailScreen> {
  @override
  Widget build(BuildContext context) {

    // print();
    Map<String, dynamic> data =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // print(data.toString());
    TechData sd = data["data"];
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
          child: Container(
            margin: EdgeInsets.all(18),
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Technology :", 17, Colors.black , fontWeight:  FontWeight.w600),
                    TextHelper.textWithColorSize(sd.tech, 17, Colors.black , fontWeight:  FontWeight.w400)
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Description :", 17, Colors.black , fontWeight:  FontWeight.w600),
                    TextHelper.textWithColorSize(sd.desc, 17, Colors.black , fontWeight:  FontWeight.w400)
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Type :", 17, Colors.black , fontWeight:  FontWeight.w600),
                    TextHelper.textWithColorSize(sd.type, 17, Colors.black , fontWeight:  FontWeight.w400)
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Type Description :", 17, Colors.black , fontWeight:  FontWeight.w600),
                    TextHelper.textWithColorSize(sd.type_desc, 17, Colors.black , fontWeight:  FontWeight.w400)
                  ],
                ),
              ],
            )
          )
        ),
      ),
    );
  }
}

