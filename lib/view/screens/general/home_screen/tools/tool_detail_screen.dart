

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



class ToolDetailScreen extends StatefulWidget {
  const ToolDetailScreen({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<ToolDetailScreen> {
  @override
  Widget build(BuildContext context) {

    // print();
    Map<String, dynamic> data =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // print(data.toString());
    ToolData sd = data["data"];
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
                    TextHelper.textWithColorSize("Name :", 20, Colors.black , fontWeight:  FontWeight.w700),
                    TextHelper.textWithColorSize(sd.name, 17, Colors.black , fontWeight:  FontWeight.w400)
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Features :", 20, Colors.black , fontWeight:  FontWeight.w700),
                    TextHelper.textWithColorSize(sd.features, 17, Colors.black , fontWeight:  FontWeight.w400)
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Image :", 20, Colors.black , fontWeight:  FontWeight.w700),
                    // TextHelper.textWithColorSize(sd.image_link, 17, Colors.black , fontWeight:  FontWeight.w400),
                    CachedNetworkImage(
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      imageUrl: sd.image_link,
                    ),
                    // new Image.network(),
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Uses :", 20, Colors.black , fontWeight:  FontWeight.w700),
                    TextHelper.textWithColorSize(sd.uses, 17, Colors.black , fontWeight:  FontWeight.w400)
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

