
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/add_crop_demand_buyer/state_and_cities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String search = "";
TextEditingController nitrogen = TextEditingController();
TextEditingController phosphorus = TextEditingController();
TextEditingController potassium = TextEditingController();
TextEditingController ph = TextEditingController();
TextEditingController rainfall = TextEditingController();
TextEditingController temperature = TextEditingController();
TextEditingController humidity = TextEditingController();

String? city = "City";
String? state = "State";


class CropPrediction extends StatefulWidget {
  final BuildContext ctx;

  const CropPrediction({Key? key, required this.ctx}) : super(key: key);

  @override
  _BuyerHomeScreenState createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<CropPrediction> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              stateAndCityPicker(),
              TextInputController.generalTextInputController(
                  context, 'Nitrogen', nitrogen),
              TextInputController.generalTextInputController(
                  context, 'Phosphorus', phosphorus),
              TextInputController.generalTextInputController(
                  context, 'Potassium', potassium),
              TextInputController.generalTextInputController(
                  context, 'ph', ph),
              TextInputController.generalTextInputController(
                  context, 'Rainfall', rainfall),
              TextInputController.generalTextInputController(
                  context, 'Temperature', temperature),
              TextInputController.generalTextInputController(
                  context, 'Humidity', humidity),
              // _profileImage != null
              //     ? SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.8,
              //   child: Image(
              //     image: FileImage(File(_profileImage!.path)),
              //   ),
              // )
              //     : Container(),
              // Row(
              //   children: [
              //     const Icon(
              //       Icons.cloud_upload,
              //       color: Colors.blue,
              //     ),
              //     _profileImage == null
              //         ? ButtonHelper.getTextButton(
              //         "Upload Crop Quality Certificate", () {
              //       _showPicker(context);
              //     })
              //         : ButtonHelper.getTextButton("Change Certificate", () {
              //       _showPicker(context);
              //     }),
              //   ],
              // ),
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
              //   ListTileControlAffinity.leading, //  <-- leading Checkbox
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
                    "Submit", () => {}),
              ),
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

  stateAndCityPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 150,
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: ConstantColors.textInputCtrl,
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            isExpanded: true,
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
                  child: Container(
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ));
            }).toList(),
            onChanged: (x) {
              setState(() {
                city = "State";
                state = x;
              });
            },
          ),
        ),
        Container(
          width: 150,
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: ConstantColors.textInputCtrl,
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            isExpanded: true,
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
}


