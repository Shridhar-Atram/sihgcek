
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/add_crop_demand_buyer/state_and_cities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// "Nitrogen": 1,
// "Phosphorus": 5,
// "Potassium" : 31,
// "SoilType": 5,
// "Moisture" : 26,
// "CropType" : 5,
// "State" : "Maharashtra",
// "City" : "Nagpur"


String search = "";
TextEditingController nitrogen = TextEditingController();
TextEditingController phosphorus = TextEditingController();
TextEditingController potassium = TextEditingController();
TextEditingController soilType = TextEditingController();
TextEditingController moisture = TextEditingController();
TextEditingController cropType = TextEditingController();
// TextEditingController humidity = TextEditingController();

String? city = "City";
String? state = "State";


class FerPrediction extends StatefulWidget {
  final BuildContext ctx;

  const FerPrediction({Key? key, required this.ctx}) : super(key: key);

  @override
  _BuyerHomeScreenState createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<FerPrediction> {
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
                  context, 'Nitrogen', nitrogen , "0 ppm" , "140 ppm"),
              TextInputController.generalTextInputController(
                  context, 'Phosphorus', phosphorus , "5 ppm" , "145 ppm"),
              TextInputController.generalTextInputController(
                  context, 'Potassium', potassium , "5 ppm" , "205 ppm"),
              TextInputController.generalTextInputController(
                  context, 'soil type', soilType , "1" , "5"),
              TextInputController.generalTextInputController(
                  context, 'soil type', soilType , "0" , "4"),
              TextHelper.textWithColorSize("0.Sandy  1.Loamy  2.Black  3.Red  4.Clayey", 13, Colors.black),
              TextInputController.generalTextInputController(
                  context, 'moisture', moisture , "20 cm" , "300 cm"),
              TextInputController.generalTextInputController(
                  context, 'crop type', cropType , "1" , "11"),
              TextHelper.textWithColorSize("1.Barley  2.Cotton  3.Ground Nuts  4.Maize  5.Millets\n6.Oil seed 7.Paddy 8.Pulses 9.Sugarcane 10.Tobacco 11.Wheat", 13, Colors.black),
              // TextInputController.generalTextInputController(
              //     context, 'Temperature', temperature),
              // TextInputController.generalTextInputController(
              //     context, 'Humidity', humidity),
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
                    "Submit", () async {
                      var data = {
                      "Nitrogen": int.parse(nitrogen.text),
                      "Phosphorus": int.parse(phosphorus.text),
                      "Potassium" : int.parse(potassium.text),
                      "SoilType": int.parse(soilType.text),
                      "Moisture" : int.parse(moisture.text),
                      "CropType" : int.parse(cropType.text),
                      "State" : state,
                      "City" : city

                        // "n": nitrogen.text,
                        // "p": phosphorus.text,
                        // "k" : potassium.text,
                        // "Ph" : ph.text,
                        // "Rain" : rainfall.text,
                        // "State" : state,
                        // "City" : city,
                      };

                      print(data);
                    var  val = await predictFer(data: data);
                        print(val);
                      Navigator.pushNamed(context, RoutePaths.resultScreenfer , arguments: {"data": val});

                    }
                      ),

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


