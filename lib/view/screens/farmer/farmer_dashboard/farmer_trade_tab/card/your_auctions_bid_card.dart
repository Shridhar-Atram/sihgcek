import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_trade_tab/auction_hosted_by_farmer/auction_details_farmer.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_trade_tab/data/farmer_auction_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YourAuctionBidCardFarmer extends StatelessWidget {
  final BuildContext ctx;
  final FarmerAuctionData  farmerAuctionData;
  const YourAuctionBidCardFarmer({Key? key , required this.ctx,  required this.farmerAuctionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuctionDetails(auctionID: farmerAuctionData.auctionID, data:farmerAuctionData))),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper.textWithColorSize("Your Phone :  " + farmerAuctionData.auctionID.substring(0 , 13) , 15 , Colors.blue , fontWeight: FontWeight.w400),
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
            TextHelper.textWithColorSize("Your Name :  " + farmerAuctionData.farmerName , 15 , Colors.blue , fontWeight: FontWeight.w400),
            const SizedBox(height: 5,),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child:TextHelper.textWithColorSize(
                  "Address : ${farmerAuctionData.village}, ${farmerAuctionData.district}, ${farmerAuctionData.state}", 15 , Colors.black),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  farmerAuctionData.transport?
                  TextHelper.textWithColorSize("Transportation Available", 15, Colors.green):
                  TextHelper.textWithColorSize("Transportation Not Available", 15, Colors.black),

                  Row(
                    children: [
                      TextHelper.textWithColorSize("Auction", 14, Colors.blue , fontWeight: FontWeight.w500)
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: ConstantColors.greyColor2,
            )
          ],
        ),
      )
    );
  }
}
