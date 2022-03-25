import 'dart:convert';
import 'dart:io';

import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/current_farmer/current_user.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_home_tab/cards/crop_demand_card.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_home_tab/data/demand_crop_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

late DemandCropDataFarmer cropData;
TextEditingController offerPer = TextEditingController();
TextEditingController quantity = TextEditingController();
// TextEditingController valid = TextEditingController();
late String certificateURL;
PickedFile? _profileImage;

class SendOfferToBuyerScreen extends StatefulWidget {
  const SendOfferToBuyerScreen({Key? key}) : super(key: key);

  @override
  _SendOfferToBuyerScreenState createState() => _SendOfferToBuyerScreenState();
}

class _SendOfferToBuyerScreenState extends State<SendOfferToBuyerScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> prevData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    cropData = prevData["data"];
    return Scaffold(
      backgroundColor: ConstantColors.whiteBackground,
      appBar: AppBar(
        title: TextHelper.textWithColorSize("Send Offer", 18, Colors.black,
            fontWeight: FontWeight.w400),
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
          CropDemandCardFarmer(ctx: context, data: cropData),
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
          certificateImage(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160,
                  child: TextInputController.simpleTextInputController(
                      context, "Offer per", offerPer,
                      prefix: "RS " , keyboardType: TextInputType.number),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                ),
                Container(
                  width: 160,
                  child: TextInputController.simpleTextInputController(
                      context, "Quantity", quantity,
                      suffix: "MT", keyboardType: TextInputType.number),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: ButtonHelper.getElevatedButton("SEND BID", () {
              sendOfferToBuyer(context);
            }),
            height: 40,
          )
        ],
      ),
    );
  }

  Future<void> sendOfferToBuyer(BuildContext context) async {
    if (offerPer.text == "" || quantity.text == "") {
      EasyLoading.showError("add data properly");
      return;
    }


    if (_profileImage == null) {
      EasyLoading.showError("add certificate");
      return;
    }

    if (!(await uploadDocsToFirestore())) {
      EasyLoading.showError("Something while adding certificate");
      return;
    }

    EasyLoading.show(status: "Adding Bid");

    try {
      Map<String, dynamic> v = cropData.toJson();
      v.addAll({
        "farmerName":CurrentFarmerUser.name,
        "farmerID": CurrentFarmerUser.farmerID,
        "offerperUnitAsked": int.tryParse(offerPer.text) ?? 0,
        "quantityAsked": int.parse(quantity.text),
        "certificateURL" : certificateURL,
      });
      bool response = await addBidFarmer(v);
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

  certificateImage() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          _profileImage != null
              ? SizedBox(
                  height:70,
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
        ],
      ),
    );
  }
}

Future<bool> uploadDocsToFirestore() async {
  try {
    //upload profile image
    EasyLoading.show(dismissOnTap: true, status: "Uploading Image");

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference referenceProfile = storage.ref().child(
        "certificates/${FirebaseAuth.instance.currentUser?.phoneNumber}/${DateTime.now().toString()}");

    UploadTask uploadTask = referenceProfile.putFile(File(_profileImage!.path));

    var dowurl =
        await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();

    print("certificateURL : " + dowurl);
    certificateURL = dowurl;
    EasyLoading.dismiss();
    return true;
  } catch (e) {
    print(e.toString());
    EasyLoading.showError("Something Went Wrong :(");
    return false;
  }
}
