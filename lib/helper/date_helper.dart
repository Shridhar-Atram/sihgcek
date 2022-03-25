import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
DateTime time = DateTime.now();
class ChooseDateBox extends StatefulWidget {
  final Function date;
  final String text;
  const ChooseDateBox({required this.date , Key? key , required this.text}) : super(key: key);

  @override
  _ChooseDateBoxState createState() => _ChooseDateBoxState();
}

class _ChooseDateBoxState extends State<ChooseDateBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            width: MediaQuery.of(context).size.width,
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: ConstantColors.textInputCtrl,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper.textWithColorSize(time.toString().substring(0, 10), 15,Colors.black),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
          onTap: () async {
            DateTime curr = await _selectDate(context);
            setState(() {
              time = curr;
              widget.date(time);
            });
          },
        ),
        Container(
          child: TextHelper.textWithColorSize(widget.text, 12 ,Colors.black),
        ),
      ],
    );
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
