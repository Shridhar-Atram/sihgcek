
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_trade_tab/auction_hosted_by_farmer/data/auction_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DemandCardByBuyerForAuction extends StatelessWidget {
  final AuctionFullDataFarmer data;
  final String auctionID;
  const DemandCardByBuyerForAuction({Key? key, required this.data, required this.auctionID }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper.textWithColorSize("Buyer Phone :  " + data.buyerID , 15 , Colors.blue , fontWeight: FontWeight.w400),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: ConstantColors.mPrimaryColor,borderRadius: const BorderRadius.all(Radius.circular(5))),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                      child:TextHelper.textWithColorSize("LIVE" , 8 , Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
          TextHelper.textWithColorSize("Buyer Name :  " + data.buyerName, 15 , Colors.blue , fontWeight: FontWeight.w400),
          const SizedBox(height: 5,),
          TextHelper.textWithColorSize(data.cropName , 16 , Colors.green ,fontWeight: FontWeight.w500),
          const SizedBox(height: 5,),
          TextHelper.textWithColorSize("Offer per unit :  "+   data.offerperUnitAsked.toString() + " Rs", 15 , Colors.black),
          const SizedBox(height: 5,),
          TextHelper.textWithColorSize("Total Quantity Want :  " + data.quantityAsked.toString()+" Kg", 15, Colors.black),
          const SizedBox(height: 5,),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child:TextHelper.textWithColorSize(
                "Address : ${data.village}, ${data.district}, ${data.state}", 15 , Colors.black),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // SizedBox(
                //     width: 100,
                //     child: ButtonHelper.getElevatedButton(
                //       "Ignore",
                //           () => updateOffer(context, auctionID, "Reject"),
                //     )),
                SizedBox(
                    width: 100,
                    child: ButtonHelper.getElevatedButton(
                      "Accept",
                          () => updateOffer(context, auctionID, "Accept"),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  updateOffer(BuildContext context, String auctionID , String status) async {
    EasyLoading.show(status: "Updating status");
    try {
      var res = await updateBidFarmer(auctionFullData: data );

        if(res == "done"){
          EasyLoading.showSuccess("Order ${status}ed");
          Navigator.of(context).pop();
        }else{
          PP.p(res);
          EasyLoading.showError("Something went wrong");
        }
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    EasyLoading.dismiss();

  }
}
