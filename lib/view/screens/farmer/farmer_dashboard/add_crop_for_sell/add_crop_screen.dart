import 'dart:io';

import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/current_farmer/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import 'state_and_cities.dart';

TextEditingController cropName = TextEditingController();
TextEditingController minQun = TextEditingController();
TextEditingController totalQun = TextEditingController();
TextEditingController variety = TextEditingController();
TextEditingController village = TextEditingController();
TextEditingController offerPerUnit = TextEditingController();
late String certificateURL;
PickedFile? _profileImage;
bool transportFacilitated = false;
String? city = "Select District";
String? state = "Select State";
DateTime biddingOpeningDate = DateTime.now();
DateTime biddingClosingDate = DateTime.now();

class AddCropScreenFarmer extends StatefulWidget {
  const AddCropScreenFarmer({Key? key}) : super(key: key);

  @override
  _AddCropScreenFarmerState createState() => _AddCropScreenFarmerState();
}

class _AddCropScreenFarmerState extends State<AddCropScreenFarmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Crop For Sell"),
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
                    "Add Crop For Sell", 18, Colors.black,
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
                  context, "Variety / Quality", variety,),
                TextInputController.numberInputController(
                    context, "Offer Per Unit", offerPerUnit, "Offer Per Unit"),
                stateAndCityPicker(),
                TextInputController.simpleTextInputController(
                    context, 'Village', village),
                _profileImage != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Image(
                          image: FileImage(File(_profileImage!.path)),
                        ),
                      )
                    : Container(),
                Row(
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                      color: Colors.blue,
                    ),
                    _profileImage == null
                        ? ButtonHelper.getTextButton(
                            "Upload Crop Quality Certificate", () {
                            _showPicker(context);
                          })
                        : ButtonHelper.getTextButton("Change Certificate", () {
                            _showPicker(context);
                          }),
                  ],
                ),
                // openingDatePicker(),
                // closingDatePicker(),
                CheckboxListTile(
                  title: const Text("Transportation Facilitated"),
                  value: transportFacilitated,
                  onChanged: (newValue) {
                    setState(() {
                      transportFacilitated = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
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
                      "Add Crop For Sell", () => addCrop()),
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
          child: TextHelper.textWithColorSize("Bid start date", 12, Colors.black),
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

  void _imgFromCamera() async {
    PickedFile? image = (await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 40));

    setState(() {
      _profileImage = image!;
    });
  }

  void _imgFromGallery() async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      _profileImage = image!;
    });
  }

  void _showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () async {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void changeDate(DateTime x) {
    biddingOpeningDate = x;
  }

  void changeDateClosingDate(DateTime x) {
    biddingClosingDate = x;
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
          .showSnackBar(const SnackBar(content: Text("Select District")));
    } else if (village.text == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Village Name")));
    } else if (_profileImage == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Add Certificate")));
    } else {
      addCropForSell();
    }
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

  Future<void> addCropForSell() async {
    try {
      if (!(await uploadDocsToFirestore())) {
        return;
      }
      EasyLoading.show(status: "Adding Crop");
      bool res = await addCropForSellAPIToFirebase(
          auctionId: CurrentFarmerUser.farmerID + DateTime.now().toString(),
          farmerName: CurrentFarmerUser.name,
          state: state ?? "",
          cropName: cropName.text,
          district: city ?? "",
          totalQuantity: int.tryParse(totalQun.text)??0,
          minimumQuantity: int.parse(minQun.text),
          farmerID: CurrentFarmerUser.farmerID,
          offerperUnit: int.tryParse(offerPerUnit.text)??0,
          endDate: biddingClosingDate.millisecondsSinceEpoch,
          startDate: biddingOpeningDate.millisecondsSinceEpoch,
          variety: variety.text,
          village: village.text,
          transport: transportFacilitated,
          certificateURL: certificateURL,);

      if (res) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Crop Added");
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

  Future<bool> uploadDocsToFirestore() async {
    try {
      //upload profile image
      EasyLoading.show(dismissOnTap: true, status: "Uploading Image");

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference referenceProfile = storage.ref().child(
          "certificates/${FirebaseAuth.instance.currentUser?.phoneNumber}/${DateTime.now().toString()}");

      UploadTask uploadTask =
          referenceProfile.putFile(File(_profileImage!.path));

      var downloadURL = await (await uploadTask.whenComplete(() => null))
          .ref
          .getDownloadURL();

      certificateURL = downloadURL;
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      EasyLoading.showError("Something Went Wrong :(");
      return false;
    }
  }
}
