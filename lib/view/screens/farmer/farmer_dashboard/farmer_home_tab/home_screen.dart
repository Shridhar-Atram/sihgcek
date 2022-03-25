import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_home_tab/sell_demand_listviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'crop_name_list.dart';

String search = "";

class FarmerHomeScreen extends StatefulWidget {
  final BuildContext ctx;

  const FarmerHomeScreen({Key? key, required this.ctx}) : super(key: key);

  @override
  _FarmerHomeScreenState createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              CropNameList(fun: changeSearch, search: search),
              Container(
                margin: EdgeInsets.all(5),
                child: GestureDetector(
                  child: search == ""
                      ? Container()
                      : TextHelper.textWithColorSize("Clear", 16, Colors.blue , fontWeight: FontWeight.w500),
                  onTap: () {
                    setState(() {
                      search = "";
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SellDemand(
                ctx: widget.ctx,
                search: search,
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeSearch(String s) {
    setState(() {
      search = s.toLowerCase();
    });
  }
}
