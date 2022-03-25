
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/constants/lmagepaths/logopaths.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/add_crop_demand_buyer/state_and_cities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'name_card.dart';

class HomeScreenGeneral extends StatefulWidget {
  final BuildContext ctx;

  const HomeScreenGeneral({Key? key, required this.ctx}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenGeneral> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Center(
        child: Container(
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(maxWidth: 500),
          margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    child: Image.asset(LogoPaths.imagePath),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 18),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: const Text(
                            "Notification",
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          alignment: Alignment.topRight,
                        ),
                        const Text(
                          "Notification : new schema has been arrived click here to apply",
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ConstantColors.mPrimaryColor)
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            NameCard(name: 'Crops',),
                            NameCard(name: 'Tools & instruments',),
                            NameCard(name: 'Techniques',),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            NameCard(name: 'Schemas',),
                            NameCard(name: 'Import & Export',),
                            NameCard(name: 'Crop Shop',),
                          ],
                        ),

                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
                    child: Image.asset(LogoPaths.indiaMap),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextHelper.textWithColorSize("Latest Update", 25, ConstantColors.mPrimaryColor , fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        child: const Text(
                          "News 1 : India, China Foreign Ministers Meet, First After Border Clash",
                          style: TextStyle(
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: const Text(
                          "News 1 : India, China Foreign Ministers Meet, First After Border Clash",
                          style: TextStyle(
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: const Text(
                          "News 1 : India, China Foreign Ministers Meet, First After Border Clash",
                          style: TextStyle(
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: const Text(
                          "News 1 : India, China Foreign Ministers Meet, First After Border Clash",
                          style: TextStyle(
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      )
                    ],
                  )
                ],
              )
            ],
          )
        )
      ),
    );
  }
}


