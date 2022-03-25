import 'dart:io';

import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/current_logged_buyer/current_user.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/home_tab_buyer/cards/crop_buy_card.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/home_tab_buyer/data/buy_crop_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

late CropBuyDataBuyer cropData;
TextEditingController offerPer = TextEditingController();
TextEditingController quantity = TextEditingController();
// TextEditingController valid = TextEditingController();

class SendOfferToFarmerScreen extends StatelessWidget {
  const SendOfferToFarmerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> prevData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    cropData = prevData["data"];
    return Scaffold(
      backgroundColor: ConstantColors.whiteBackground,
      appBar:
          AppBarHelper.getSimpleAppBar(context: context, name: "Send Offer"),
      body: Center(
        child: Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(maxWidth: 500),
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [infoCard(context), sendOffer(context)],
            )),
      ),
    );
  }

  infoCard(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Wrap(
        children: [
          CropSellCardBuyer(ctx: context, data: cropData),
        ],
      ),
    ));
  }

  sendOffer(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ButtonHelper.getTextButton("See Crop Quality Certificate", () {
            Navigator.pushNamed(context, RoutePaths.seeCertificateImage,
                arguments: {"url": cropData.certificateUrl});
          }),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  child: TextInputController.simpleTextInputController(
                      context, "Offer per", offerPer,
                      prefix: "Rs "),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                ),
                Container(
                  width: 150,
                  child: TextInputController.simpleTextInputController(
                      context, "Quantity", quantity,
                      suffix: " MT"),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: ButtonHelper.getElevatedButton("SEND BID", () {
              sendOfferToFarmer(context, cropData);
            }),
            height: 40,
          )
        ],
      ),
    );
  }

  Future<void> sendOfferToFarmer(
      BuildContext context, CropBuyDataBuyer cropData) async {
    EasyLoading.show(status: "Adding Bid", dismissOnTap: true);
    if (offerPer.text == "" || quantity.text == "") {
      EasyLoading.showError("add data properly");
      return;
    }
    try {
      Map<String, dynamic> v = cropData.toJson();
      v.addAll({
        "buyerName":CurrentBuyerUser.name,
        "buyerID": CurrentBuyerUser.buyerID,
        "offerperUnitAsked": int.tryParse(offerPer.text) ?? 0,
        "quantityAsked": int.parse(quantity.text)
      });
      bool response = await addBidBuyer(v);
      if (response) {
          EasyLoading.showSuccess("Bid added");
          Navigator.pop(context);
      }
    } on SocketException {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No internet Connection"),
      ));
    } catch (e) {
      EasyLoading.dismiss();
      PP.p(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something Went Wrong"),
      ));
      EasyLoading.dismiss();
    }
  }
}
