import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_trade_tab/recent_bids_widget.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_trade_tab/your_auction_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'accepted_bids_of_farmer/accepted_screen.dart';
import 'accepted_offer_by_farmer/accepted_offer_screen.dart';


class FarmerTradeScreen extends StatefulWidget {
  final BuildContext ctx;

  const FarmerTradeScreen({Key? key, required this.ctx}) : super(key: key);

  @override
  _FarmerTradeScreenState createState() => _FarmerTradeScreenState();
}

class _FarmerTradeScreenState extends State<FarmerTradeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            totalBidsAndOffer(
                context: context,),
            const SizedBox(
              height: 15,
            ),
            RecentBidsWidget(
                ctx: widget.ctx),
            const SizedBox(
              height: 15,
            ),
            YourAuctionWidget(
              ctx: widget.ctx,
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

totalBidsAndOffer(
    {required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.all(10),
    color: Colors.white,
    child: Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,

          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AcceptedBidScreen())),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHelper.textWithColorSize(
                              "My Accepted Bids ", 15, Colors.red,
                              fontWeight: FontWeight.w400),
                          TextHelper.textWithColorSize(
                              "Your accepted bids will appear here",
                              12,
                              Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
        GestureDetector(
            behavior: HitTestBehavior.translucent,

            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AcceptedOffer())),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHelper.textWithColorSize(
                              "My Auctions", 15, Colors.red,
                              fontWeight: FontWeight.w400),
                          TextHelper.textWithColorSize(
                              "Your accepted offers will appear here",
                              12,
                              Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ],
              ))
        ),
      ],
    ),
  );
}
