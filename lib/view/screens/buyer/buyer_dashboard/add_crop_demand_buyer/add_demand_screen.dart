
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/add_crop_demand_buyer/state_and_cities.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/current_logged_buyer/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

TextEditingController cropName = TextEditingController();
TextEditingController minQun = TextEditingController();
TextEditingController totalQun = TextEditingController();
TextEditingController variety = TextEditingController();
TextEditingController village = TextEditingController();
// TextEditingController transportationPrice = TextEditingController();
TextEditingController offerPerUnit = TextEditingController();
bool transportFacilitated = false;
String? city = "Select District";
String? state = "Select State";
DateTime biddingOpeningDate = DateTime.now();
DateTime biddingClosingDate = DateTime.now();

class AddDemandScreen extends StatefulWidget {
  const AddDemandScreen({Key? key}) : super(key: key);

  @override
  _AddDemandScreenState createState() => _AddDemandScreenState();
}

class _AddDemandScreenState extends State<AddDemandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
          child: Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(maxWidth: 500),
            margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextHelper.textWithColorSize(
                    "Add demand for crops", 18, Colors.black,
                    fontWeight: FontWeight.w400),
                const SizedBox(
                  height: 15,
                ),
                TextInputController.simpleTextInputController(
                    context, 'Crop Name', cropName),
                TextInputController.numberInputController(context,
                    "Total Quantity Available", totalQun, "Enter In MT"),
                TextInputController.numberInputController(context,
                    "Minimum Quantity Available", minQun, "Enter In MT"),
                TextInputController.simpleTextInputController(
                  context,
                  "Variety / Quality",
                  variety,
                ),
                TextInputController.numberInputController(
                    context, "Offer Per Unit", offerPerUnit, "Offer Per Unit"),
                stateAndCityPicker(),
                TextInputController.simpleTextInputController(
                    context, 'Village', village),
                // openingDatePicker(),
                // closingDatePicker(),
                // CheckboxListTile(
                //   title: const Text("Transportation Facilitated"),
                //   value: transportFacilitated,
                //   onChanged: (newValue) {
                //     setState(() {
                //       transportFacilitated = newValue!;
                //     });
                //   },
                //   controlAffinity:
                //       ListTileControlAffinity.leading, //  <-- leading Checkbox
                // ),
                // transportFacilitated
                //     ? TextInputController.numberInputController(
                //         context,
                //         "Enter Transportation Facilitated",
                //         transportationPrice,
                //         "Enter In Rs")
                //     : Container(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, bottom: 30),
                  height: 48,
                  child: ButtonHelper.getElevatedButton(
                      "Add demand for crops", () => addCrop()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openingDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: ConstantColors.textInputCtrl,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper.textWithColorSize(
                    biddingOpeningDate.toString().substring(0, 10),
                    15,
                    Colors.black),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
          onTap: () async {
            DateTime curr = await _selectDate(context);
            setState(() {
              biddingOpeningDate = curr;
            });
          },
        ),
        Container(
          child:
              TextHelper.textWithColorSize("Bid start date", 12, Colors.black),
        ),
      ],
    );
  }

  closingDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: ConstantColors.textInputCtrl,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper.textWithColorSize(
                    biddingClosingDate.toString().substring(0, 10),
                    15,
                    Colors.black),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
          onTap: () async {
            DateTime curr = await _selectDate(context);
            setState(() {
              biddingClosingDate = curr;
            });
          },
        ),
        Container(
          child: TextHelper.textWithColorSize("Bid end date", 12, Colors.black),
        ),
      ],
    );
  }

  stateAndCityPicker() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: ConstantColors.textInputCtrl,
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            iconDisabledColor: ConstantColors.textInputCtrl,
            iconEnabledColor: ConstantColors.textInputCtrl,
            underline: const SizedBox(
              height: 0,
            ),
            iconSize: 42,
            hint: Text(state!),
            items: states.map((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                  ));
            }).toList(),
            onChanged: (x) {
              setState(() {
                city = "Select District";
                state = x;
              });
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: ConstantColors.textInputCtrl,
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            iconDisabledColor: ConstantColors.textInputCtrl,
            iconEnabledColor: ConstantColors.textInputCtrl,
            underline: const SizedBox(
              height: 0,
            ),
            iconSize: 42,
            hint: Text(city!),
            items: cities[state]!.map((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: SizedBox(
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ));
            }).toList(),
            onChanged: (x) {
              setState(() {
                city = x;
              });
            },
          ),
        ),
      ],
    );
  }

  addCrop() {
    if (cropName.text == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Crop Name")));
    } else if (totalQun.text == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Total Quantity")));
    } else if (minQun.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Enter Minimum Quantity")));
    } else if (variety.text == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Total Quantity")));
    } else if (state == "Select State") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Select State")));
    } else if (city == "Select District") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Select City")));
    } else if (village.text == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Village Name")));
    } else {
      addDemand();
    }
  }

  Future<void> addDemand() async {
    EasyLoading.show(status: "Adding Demand");
    try {
      bool res = await addDemandOfCropToFirebase(
          auctionID: CurrentBuyerUser.buyerID + " " + DateTime.now().toString(),
          buyerName: CurrentBuyerUser.name,
          state: state ?? "",
          cropName: cropName.text,
          district: city ?? "",
          totalQuantity: int.tryParse(totalQun.text) ?? 0,
          minimumQuantity: int.tryParse(minQun.text) ?? 0,
          buyerID: CurrentBuyerUser.buyerID,
          offerperUnit: int.tryParse(offerPerUnit.text) ?? 0,
          variety: variety.text,
          village: village.text);

      if (res) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Demand Added");
        Navigator.of(context).pop();
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something Went Wrong")));
      }
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    EasyLoading.dismiss();
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2055, 8));
    if (picked != null && picked != selectedDate) {
      return picked;
    }
    return DateTime.now();
  }
}
