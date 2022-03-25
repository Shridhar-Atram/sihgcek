import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/trade_tab_buyer/data/recent_bid_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'crop_sell_card_for_recend_bid.dart';


late RecentBidDataBuyer cropData;

class RecentBidInfoBuyer extends StatelessWidget {
  const RecentBidInfoBuyer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String , dynamic> prevData =  ModalRoute.of(context)?.settings.arguments as Map<String  ,dynamic>;
    cropData = prevData["data"];
    return Scaffold(
      backgroundColor: ConstantColors.whiteBackground,
          appBar: AppBar(
            title:TextHelper.textWithColorSize("Your Recent Bids" , 18 , Colors.black , fontWeight: FontWeight.w400),
            backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back ,color: Colors.black,),
            onPressed: () {
              Navigator.pop(context, true);
            }
        ),),
      body: Stack(
        children: [
          Center(
            child: Container(
                alignment: Alignment.centerLeft,
                constraints: const BoxConstraints(maxWidth: 500),
                margin: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    infoCard(context),
                    sendOffer(context)
                  ],
                )
            ),
          ),
          getBottomNavigation()
        ],
      ),
    );
  }

  infoCard(BuildContext context) {
    return SingleChildScrollView(
      child: CropSellCardForRecent(
        ctx: context,
        data: cropData,
      ),
    );
  }

  sendOffer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                Border.all(color: ConstantColors.mPrimaryColor, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Active",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text("Your Price"),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Rs ${cropData.offerperUnitAsked.toString()}/ MT",
                            style: const TextStyle(color: Colors.grey))
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Your Quantity"),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("${cropData.quantityAsked.toString()} MT",
                            style: const TextStyle(color: Colors.grey))
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

    getBottomNavigation() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(15),
        color: ConstantColors.scaffoldBackground,
        alignment: Alignment.bottomCenter,
        child: TextHelper.textWithColorSize("Your order has been successfully placed, please wait for the counterparty to approve or deny the offer", 15, Colors.white),
      ),
    );
  }
}
