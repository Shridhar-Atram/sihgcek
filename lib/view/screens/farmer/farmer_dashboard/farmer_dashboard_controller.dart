import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/view/dialogs/lang_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'farmer_home_tab/home_screen.dart';
import 'farmer_trade_tab/trade_screen.dart';

int selectedIndex = 0;

class FarmerDashboardController extends StatefulWidget {
  const FarmerDashboardController({Key? key}) : super(key: key);

  @override
  _FarmerDashboardControllerState createState() =>
      _FarmerDashboardControllerState();
}

class _FarmerDashboardControllerState extends State<FarmerDashboardController> {
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      FarmerHomeScreen(ctx: context),
      FarmerTradeScreen(ctx:context),
    ];

    return SafeArea(child: Scaffold(
        backgroundColor: ConstantColors.whiteBackground,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ConstantColors.mPrimaryColor,
          child: const Icon(
            Icons.add,color: Colors.white,
          ),
          onPressed: () {Navigator.pushNamed(context, RoutePaths.addCropScreen);},
        ),
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
          label: "Trade",
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
          chooseLang(),
        TextHelper.textWithColorSize("Farmer" , 20, ConstantColors.mPrimaryColor , fontWeight: FontWeight.w500),
          GestureDetector(
            child: const Icon(Icons.settings),
            onTap: (){Navigator.pushNamed(context, RoutePaths.settings);},
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
