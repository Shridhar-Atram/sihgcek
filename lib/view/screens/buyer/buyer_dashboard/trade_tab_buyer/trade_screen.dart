import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/trade_tab_buyer/recent_bids_widget.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/trade_tab_buyer/your_auction_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'accepted_bids_of_buyer/accepted_screen.dart';
import 'accepted_offers_by_buyer/accepted_offer_screen.dart';

class TradeScreen extends StatefulWidget {
  final BuildContext ctx;

  const TradeScreen({Key? key, required this.ctx}) : super(key: key);

  @override
  _TradeScreenState createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Center(
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
              totalBidsAndOffer(context: context),
              const SizedBox(
                height: 15,
              ),
              RecentBidsWidget(
                ctx: widget.ctx,
              ),
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

totalBidsAndOffer({required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.all(10),
    color: Colors.white,
    child: Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AcceptedBidScreenBuyer())),
          child: Container(
              width: MediaQuery.of(context).size.width,
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
                              "My Accepted Bids", 15, Colors.red,
                              fontWeight: FontWeight.w400),
                          TextHelper.textWithColorSize(
                              "Your accepted Bids will appear here",
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
                builder: (context) => const AcceptedOfferScreenBuyer())),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextHelper.textWithColorSize(
                                "My Auction", 15, Colors.red,
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
                ))),
      ],
    ),
  );
}
