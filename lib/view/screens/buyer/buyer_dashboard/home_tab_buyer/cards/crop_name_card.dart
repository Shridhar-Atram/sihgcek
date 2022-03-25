import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CropInfoCardBuyer extends StatelessWidget {
final String name;
final String path;
final String search;

const CropInfoCardBuyer(
{required this.name, Key? key, required this.path, required this.search})
: super(key: key);

@override
Widget build(BuildContext context) {
  return search.toLowerCase() == name.toLowerCase() ? Card(
    color: ConstantColors.mPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 3,
    margin: const EdgeInsets.all(10),
    child: SizedBox(
      child: Center(child: Text(name,style: const TextStyle(color: Colors.white))),
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
