import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MLoader{
  static Widget mLoader(double size){
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        backgroundColor: ConstantColors.mPrimaryColor,
      ),
    );
  }
}