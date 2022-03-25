

import 'package:e_agri_farmers/constants/lmagepaths/logopaths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'name_card.dart';

class CropTypes extends StatefulWidget {
  const CropTypes({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<CropTypes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Crop For Sell"),
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
            margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      NameCard(name: 'Cereals',),
                      NameCard(name: 'Fruits',),
                      NameCard(name: 'Seed plants',),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      NameCard(name: 'Vegetables',),
                    ],
                  ),

                ],
              )
          ),
        ),
      ),
    );
  }
}
