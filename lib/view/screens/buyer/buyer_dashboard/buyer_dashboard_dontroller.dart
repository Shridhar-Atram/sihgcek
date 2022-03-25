import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/utils/LocalStorage/shared_preferences.dart';
import 'package:e_agri_farmers/view/dialogs/lang_dialog.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/trade_tab_buyer/trade_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'current_logged_buyer/current_user.dart';
import 'home_tab_buyer/home_screen.dart';

int selectedIndex = 0;

class BuyerDashboardController extends StatefulWidget {
  const BuyerDashboardController({Key? key}) : super(key: key);

  @override
  _BuyerDashboardControllerState createState() =>
      _BuyerDashboardControllerState();
}

class _BuyerDashboardControllerState extends State<BuyerDashboardController> {
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    CurrentBuyerUser.buyerID = UserPreferences.getBuyerID()!;

    List<Widget> _widgetOptions = <Widget>[
      BuyerHomeScreen(ctx: context),
      TradeScreen(ctx:context),
    ];

    return SafeArea(child: Scaffold(
        backgroundColor: ConstantColors.whiteBackground,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ConstantColors.mPrimaryColor,
          child: const Icon(
            Icons.add,color: Colors .white,
          ),
          onPressed: () async {await Navigator.pushNamed(context, RoutePaths.addDemandScreen);},
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
          TextHelper.textWithColorSize("Buyer" , 20, ConstantColors.mPrimaryColor , fontWeight: FontWeight.w500),
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
