import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class TextInputController{
   static Widget simpleTextInputController(BuildContext context , String name , TextEditingController x , {String prefix = "" , String suffix = "" , TextInputType keyboardType = TextInputType.name }){
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: x,
        keyboardType: keyboardType,
        decoration: getInputDecoration(hintText: name,prefix: prefix , suffix: suffix),
      ),
    );
  }

   static Widget generalTextInputController(BuildContext context , String name , TextEditingController x , {String prefix = "" , String suffix = "" , TextInputType keyboardType = TextInputType.name }){
     return Container(
       margin: const EdgeInsets.only(top: 10, bottom: 10),
       child: TextFormField(
         controller: x,
         keyboardType: TextInputType.number,
         cursorColor: ConstantColors.mPrimaryColor,
         decoration: InputDecoration(
           // prefix: Text(prefix , style: TextStyle(color: ConstantColors.mPrimaryColor),),
           // filled: true,
           // suffix: Text(suffix , style: TextStyle(color: ConstantColors.mPrimaryColor),),
           hintText: name,
           hintStyle: TextStyle(fontWeight: FontWeight.w700 )
           // fillColor: ConstantColors.textInputCtrl,
           // helperText: name,
           // border: OutlineInputBorder(
           //   borderSide: BorderSide.none,
           //   borderRadius: BorderRadius.circular(8.0),
           // ),
         ),
       ),
     );
   }

   static Widget numberInputController(BuildContext context , String name , TextEditingController x , String helperText){
     return Container(
       margin: const EdgeInsets.only(top: 10, bottom: 10),
       child: TextFormField(
         controller: x,
         keyboardType: TextInputType.number,
         decoration: getInputDecorationWithHelpText(hintText: name,helpText: helperText),
       ),
     );
   }

   static Widget emailTextInputController(BuildContext context , String name , TextEditingController x){
     return Container(
       margin: const EdgeInsets.only(top: 10, bottom: 10),
       child: TextFormField(
         autovalidate: true,
         controller: x,
         validator: (input) =>
         input!.isValidEmail() ? null : "Check your Email",
         keyboardType: TextInputType.emailAddress,
         decoration:
         getInputDecoration(hintText: name),
       ),
     );
   }

   static Widget phoneInputCtrl(BuildContext context , String name , TextEditingController x){
     return Container(
       margin: const EdgeInsets.only(top: 10, bottom: 10),
       child: TextFormField(
         autovalidate: true,
         maxLength: 10,
         controller: x,
         validator: (input) =>
         input!.isValidPhone() ? null : "Check Your Phone Number",
         keyboardType: TextInputType.phone,
         decoration:
         getPhoneInputDecoration(hintText: name,),
       ),
     );
   }

   static Widget aadharInputCtrl(BuildContext context , String name , TextEditingController x){
     return Container(
       margin: const EdgeInsets.only(top: 10, bottom: 10),
       child: TextFormField(
         maxLength: 12,
         controller: x,
         keyboardType: TextInputType.phone,
         decoration:
         getInputDecoration(hintText: name,),
       ),
     );
   }
   static Widget sixDigitOTPCtrl(BuildContext context , String name , TextEditingController x){
     return PinInputTextField(
       enabled: true,
       autoFocus: true,
       enableInteractiveSelection: true,
       keyboardType: TextInputType.number,
       pinLength: 6,
       controller: x,
       decoration: BoxLooseDecoration(
         strokeColorBuilder:
         PinListenColorBuilder(Colors.transparent, Colors.transparent),
         bgColorBuilder:
         PinListenColorBuilder(ConstantColors.textInputCtrl2, ConstantColors.textInputCtrl2),
         // hintText: _kDefaultHint,
       ),
     );
   }
}
InputDecoration getInputDecorationWithHelpText({String hintText = "" , String helpText = ""}) {
  return InputDecoration(
    filled: true,
    hintText: hintText,
    fillColor: ConstantColors.textInputCtrl,
    helperText: helpText,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}

InputDecoration getInputDecoration({String hintText = "" , String suffix = "" , String prefix = ""}) {
  return InputDecoration(
    prefix: Text(prefix , style: TextStyle(color: ConstantColors.mPrimaryColor),),
    filled: true,
    suffix: Text(suffix , style: TextStyle(color: ConstantColors.mPrimaryColor),),
    hintText: hintText,
    fillColor: ConstantColors.textInputCtrl,
    helperText: hintText,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
InputDecoration getPhoneInputDecoration({String hintText = ""}) {
  return InputDecoration(
    prefix: const Text("+91"),
    filled: true,
    hintText: hintText,
    fillColor: ConstantColors.textInputCtrl,
    helperText: hintText,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}


extension PhoneValidator on String {
  bool isValidPhone() {
    if(this == ""){
      return true;
    }
    return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(this);
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    if(this == ""){
      return true;
    }
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}


PinDecoration pinDecoration = const BoxLooseDecoration(
  gapSpace: 12.0,
  strokeWidth: 10,
  strokeColorBuilder: FixedColorBuilder(Colors.transparent),
);