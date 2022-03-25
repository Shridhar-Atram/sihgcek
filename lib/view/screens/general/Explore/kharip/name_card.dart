import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameCard extends StatelessWidget {
final String name;
// final String path;
// final String search;

const NameCard(
{required this.name, Key? key})
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
      child: Center(child: Text(name,  textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          // style: TextStyle(fontSize: 18.0),
          maxLines: 2,style: const TextStyle(color: Colors.white  , fontWeight: FontWeight.w700))),
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
