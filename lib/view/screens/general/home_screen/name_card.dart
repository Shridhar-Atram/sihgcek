import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/constants/lmagepaths/logopaths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameCard extends StatelessWidget {
final String name;
final String val;
// final String path;
// final String search;

const NameCard(
{required this.name, required this.val , Key? key})
: super(key: key);

@override
Widget build(BuildContext context) {
  return true ? Card(
    color: ConstantColors.mPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 3,
    margin: const EdgeInsets.all(10),
    child: SizedBox(
      child: Image.asset("assets/images/"+ val +".png"),
      height: 100,
      width: 80,
    ),
  ) : Card(
    color:Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 3,
    margin: const EdgeInsets.all(10),
    child: SizedBox(
      child: Center(child: Text(name )),
      height: 100,
      width: 80,
    ),
  );
}
}
