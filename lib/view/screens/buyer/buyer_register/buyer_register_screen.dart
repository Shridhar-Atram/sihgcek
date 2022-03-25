
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:e_agri_farmers/helper/button_helper.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/helper/text_input_controller.dart';
import 'package:e_agri_farmers/services/HTTP/api.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/add_crop_demand_buyer/state_and_cities.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_register/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
String? city = "Select District";
String? state = "Select State";
TextEditingController nameCtrl = TextEditingController();
TextEditingController emailCtrl = TextEditingController();
TextEditingController phoneCtrl = TextEditingController();
TextEditingController aadharCtrl = TextEditingController();
TextEditingController addressCtrl1 = TextEditingController();
TextEditingController addressCtrl2 = TextEditingController();

TextEditingController roleCtrl = TextEditingController();
TextEditingController cmpNameCtrl = TextEditingController();
TextEditingController cmpPanCtrl = TextEditingController();
TextEditingController cmpGstCtrl = TextEditingController();

class BuyerRegister extends StatefulWidget {
  const BuyerRegister({Key? key}) : super(key: key);

  @override
  _BuyerRegisterState createState() => _BuyerRegisterState();
}

class _BuyerRegisterState extends State<BuyerRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarHelper.getSimpleAppBar(name: "Register" , context: context),
        body : SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Center(
            child: Container(
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(maxWidth: 500),
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextHelper.textWithColorSize(
                      "Welcome Buyer", 18, ConstantColors.blueTextColor,
                      fontWeight: FontWeight.w400),
                  TextHelper.textWithColorSize(
                    "Sign Up", 18, ConstantColors.blueTextColor,),
                  const SizedBox(height: 15,),
                  TextInputController.simpleTextInputController(context , "Full Name" ,  nameCtrl),
                  TextInputController.emailTextInputController(context , 'Email' ,  emailCtrl),
                  TextInputController.phoneInputCtrl(context , "Phone Number" ,  phoneCtrl),
                  TextInputController.aadharInputCtrl(context , "Aadhar Card Number" ,  aadharCtrl),
                  TextInputController.simpleTextInputController(context , "Registered Company Name" ,  cmpNameCtrl),
                  TextInputController.simpleTextInputController(context , "Address Line 1" ,  addressCtrl1),
                  TextInputController.simpleTextInputController(context , "Address Line 2" ,  addressCtrl2),
                  stateAndCityPicker(),
                  TextInputController.simpleTextInputController(context , "Role In Company" ,  roleCtrl),
                  TextInputController.simpleTextInputController(context , "Company Pan" ,  cmpPanCtrl),
                  TextInputController.simpleTextInputController(context , "Company GSTIN" ,  cmpGstCtrl),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 20 , bottom: 30),
                    height: 48,
                    child: ButtonHelper.getElevatedButton("Sign Up", () {gotoVerify();}),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  void gotoVerify() async {
    if(nameCtrl.text == ""){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Name")));
    }else if(aadharCtrl.text.length != 12){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter valid aadhar")));
    }else if(phoneCtrl.text.length != 10){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter valid phone")));
    }else if(emailCtrl.text == ""){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter email")));
    }else if(roleCtrl.text == ""){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter role")));
    }else if(addressCtrl1.text == "" || addressCtrl2.text == "" ){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter address")));
    }else if(cmpPanCtrl.text == ""){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter pan")));
    }else if (state == "Select State") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Select State")));
    } else if (city == "Select District") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Select City")));
    }else if(cmpGstCtrl.text == ""){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter gst")));
    }else if(cmpNameCtrl.text == ""){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Company Name")));
    }else if(await  checkUserPresent(phoneCtrl.text)){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Already Present")));
    }else{
      var data = {
        "name": nameCtrl.text,
        "adhaarCard" : aadharCtrl.text,
        "contactNo": phoneCtrl.text,
        "emailId": emailCtrl.text,
        "role": roleCtrl.text,
        "address": addressCtrl1.text + " " + addressCtrl2.text + " " + city!+ " " + state! + " ",
        "panNo": cmpPanCtrl.text,
        "gstNo": cmpGstCtrl.text,
        "companyName": cmpNameCtrl.text,
        "password": "password",
        "vid" :"vid"
      };
      BuyerRegisterController buyerRegisterController =  BuyerRegisterController();
      buyerRegisterController.sendOTPAndRegister(data, context);
    }
  }

  Future<bool> checkUserPresent(String phone) async {
    EasyLoading.show(status: "Please Wait");
    var x = await loginBuyerToFirebase(
      contactNo:"+91"+phone,
    );
    EasyLoading.dismiss();
    if (x) {
      return true;
    }
    return false;
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

}
