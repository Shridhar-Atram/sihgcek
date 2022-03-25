import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cards/crop_buy_card.dart';
import 'cards/crop_demand_card.dart';
import 'controller.dart';
import 'data/buy_crop_data.dart';
import 'data/demand_crop_data.dart';

int sellDemandState = 0;

class SellDemand extends StatefulWidget {
  final String search;
  final BuildContext ctx;

  const SellDemand({Key? key, required this.ctx, required this.search})
      : super(key: key);

  @override
  _SellDemandState createState() => _SellDemandState();
}

class _SellDemandState extends State<SellDemand> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        chooseSellDemand(),
        const SizedBox(
          height: 20,
        ),
        sellDemandState == 0 ? sellCards(widget.search) : demandCards(widget.search),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }

  sellCards(String search) {
    return FutureBuilder<List<CropBuyDataBuyer>>(
      future: HomeScreenController.fetchDataForSell(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CropBuyDataBuyer>? data = snapshot.data;
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return (data[index]
                        .cropName
                        .toLowerCase()
                        .contains(search.toLowerCase()))
                    ? CropSellCardBuyer(ctx: widget.ctx, data: data[index])
                    : Container();
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default show a loading spinner.
        return Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            backgroundColor: ConstantColors.mPrimaryColor,
          ),
        );
      },
    );
  }

  demandCards(String search) {
    return FutureBuilder<List<CropDemandDataBuyer>>(
      future: HomeScreenController.fetchDataForDemand(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CropDemandDataBuyer>? data = snapshot.data;
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return (data[index]
                        .cropName
                        .toLowerCase()
                        .contains(search.toLowerCase()))
                    ? CropDemandCardBuyer(ctx: widget.ctx, data: data[index])
                    : Container();
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default show a loading spinner.
        return Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            backgroundColor: ConstantColors.mPrimaryColor,
          ),
        );
      },
    );
  }

  chooseSellDemand() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() {
            sellDemandState = 0;
          }),
          child: Container(
            color: sellDemandState == 0
                ? ConstantColors.mPrimaryColor
                : Colors.white,
            child: Text(
              "Crop for sell",
              style: TextStyle(
                color: sellDemandState == 1 ? Colors.black : Colors.white,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            sellDemandState = 1;
          }),
          child: Container(
            color: sellDemandState == 1
                ? ConstantColors.mPrimaryColor
                : Colors.white,
            child: Text(
              "Market Demand",
              style: TextStyle(
                color: sellDemandState == 0 ? Colors.black : Colors.white,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          ),
        )
      ],
    );
  }
}
