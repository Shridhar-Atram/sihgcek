import 'package:e_agri_farmers/constants/crops/crop_data.dart';
import 'package:e_agri_farmers/constants/crops/listofcrops.dart';
import 'package:flutter/material.dart';

import 'cards/crop_name_card.dart';

String searchBoxSearch = "";
TextEditingController searchBoxCtrl = TextEditingController();

class CropNameListBuyer extends StatefulWidget {
  final Function fun;
  final String search;

  const CropNameListBuyer({Key? key, required this.fun, required this.search})
      : super(key: key);

  @override
  _CropNameListBuyerState createState() => _CropNameListBuyerState();
}

class _CropNameListBuyerState extends State<CropNameListBuyer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [searchBox(), allCrops(availableCropList, searchBoxSearch)],
    );
  }

  searchBox() {
    return TextFormField(
      controller: searchBoxCtrl,
      onChanged: (str) {
        setState(() {
          searchBoxSearch = str;
        });
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        suffixIcon: GestureDetector(
            onTap: () => setState(() {
              searchBoxSearch = "";
              searchBoxCtrl.clear();
            }),
            child: const Icon(
              Icons.cancel,
              color: Colors.grey,
            )),
        filled: true,
        hintText: "Search",
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  allCrops(List<CropData> data, String totalOrdersSearch) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return data[index]
                .name
                .toUpperCase()
                .contains(totalOrdersSearch.toUpperCase())
                ? GestureDetector(
              onTap: () {
                widget.fun(data[index].name);
              },
              child: CropInfoCardBuyer(
                  name: data[index].name,
                  path: data[index].path,
                  search: widget.search),
            )
                : Container();
          }),
    );
  }
}
