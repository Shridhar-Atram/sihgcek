

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/schemes/shemadata.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';



class SchemaDetailScreen extends StatefulWidget {
  const SchemaDetailScreen({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<SchemaDetailScreen> {
  @override
  Widget build(BuildContext context) {

    // print();
    Map<String, dynamic> data =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // print(data.toString());
    SchemaData sd = data["data"];
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
                    TextHelper.textWithColorSize("Title:", 17, Colors.black , fontWeight:  FontWeight.w600),
                    TextHelper.textWithColorSize(sd.scheme, 17, Colors.black , fontWeight:  FontWeight.w400)
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Docs:", 17, Colors.black , fontWeight:  FontWeight.w600),
                    TextHelper.textWithColorSize(sd.docs, 17, Colors.black , fontWeight:  FontWeight.w400)
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Eligibility :", 17, Colors.black , fontWeight:  FontWeight.w600),
                    TextHelper.textWithColorSize(sd.eligiblity, 17, Colors.black , fontWeight:  FontWeight.w400)
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Benefit :", 17, Colors.black , fontWeight:  FontWeight.w600),
                    TextButton(
                        onPressed: () async {
                          var url = sd.benefit;
                          print(url);
                          // if(await canLaunch(url)){
                          await launch(url);
                          // }else {
                          throw 'Could not launch $url';
                          // }
                        },
                        child: TextHelper.textWithColorSize(sd.link, 15, Colors.blue)
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper.textWithColorSize("Link :", 20, Colors.black , fontWeight:  FontWeight.w700),
                    TextButton(
                      onPressed: () async {
                        var url = sd.link;
                        print(url);
                        // if(await canLaunch(url)){
                          await launch(url);
                        // }else {
                          throw 'Could not launch $url';
                        // }
                      },
                      child: TextHelper.textWithColorSize(sd.link, 15, Colors.blue)
                    ),
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

