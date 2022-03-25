
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/home_tab_buyer/sell_demand_listviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'crop_name_list.dart';


String search = "";

class BuyerHomeScreen extends StatefulWidget {
  final BuildContext ctx;

  const BuyerHomeScreen({Key? key, required this.ctx}) : super(key: key);

  @override
  _BuyerHomeScreenState createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CropNameListBuyer(fun: changeSearch, search: search),
              Container(
                margin: const EdgeInsets.all(5),
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
