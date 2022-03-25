

import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/view/dialogs/lang_dialog.dart';
import 'package:e_agri_farmers/view/screens/general/Explore/explorescreen.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'crop_prediction/crop_prediction_screen.dart';

int selectedIndex = 0;

class GeneralController extends StatefulWidget {
  const GeneralController({Key? key}) : super(key: key);

  @override
  _GeneralControllerState createState() =>
      _GeneralControllerState();
}

class _GeneralControllerState extends State<GeneralController> {
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeScreenGeneral(ctx: context),
      CropPrediction(ctx:context),
      CropPrediction(ctx: context),
      ExploreScreen(ctx:context),
    ];

    return SafeArea(child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              topBar(context),
              _widgetOptions.elementAt(selectedIndex)
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar()));
  }



  bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      unselectedFontSize: 12,
      unselectedIconTheme:
      IconThemeData(color: ConstantColors.greyColor, size: 20),
      selectedFontSize: 12,
      selectedItemColor: ConstantColors.mPrimaryColor,
      selectedIconTheme:
      IconThemeData(color: ConstantColors.mPrimaryColor, size: 20),
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        color: ConstantColors.mPrimaryColor,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        color: ConstantColors.mPrimaryColor,
      ),
      unselectedItemColor: ConstantColors.greyColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border_sharp),
          label: "Predict crop",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Fertiliser",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Explore",
        ),
      ],
      elevation: 5,
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      iconSize: 30,
      type: BottomNavigationBarType.fixed,
    );
  }
  Widget topBar(BuildContext ctx) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20 , horizontal: MediaQuery.of(context).size.width*0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: 35,
            width: 200,
            child: Image.asset("assets/logos/mainlogo.png"),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: chooseLang(),
              ),
              GestureDetector(
                child: const Icon(Icons.more_vert),
                onTap: (){Navigator.pushNamed(context, RoutePaths.generalController);},
              )
            ],
          )
        ],
      ),
    );
  }

  chooseLang() {
    return GestureDetector(
      child: const Icon(Icons.translate),
      onTap: () => LangDialog.showLangDialog(context),
    );
  }
}
