import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:flutter/material.dart';

class AppBarHelper{
  static AppBar getSimpleAppBar({required BuildContext context, required String name}){
    return AppBar(
      title: TextHelper.textWithColorSize(name, 18, Colors.black,
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
    );
  }
}