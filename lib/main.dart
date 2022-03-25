import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/buyer_dashboard_dontroller.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_login/login_screen.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_login/verify_login.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_register/buyer_register_screen.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_register/buyer_verify.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_dashboard_controller.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_login/login_screen.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_login/verify_login.dart';
import 'package:e_agri_farmers/view/screens/general/Explore/kharip/croptypes.dart';
import 'package:e_agri_farmers/view/screens/general/crop_prediction/crop_prediction_screen.dart';
import 'package:e_agri_farmers/view/screens/general/general_controller.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/schemes/scheme_detail_screen.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/schemes/scheme_screen.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/techniques/tech_detail_screen.dart';
import 'package:e_agri_farmers/view/screens/general/home_screen/techniques/tech_screen.dart';

import 'package:e_agri_farmers/view/screens/onboard/choose_type.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_register/farmer_register_screen.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_register/verify_farmer.dart';
import 'package:e_agri_farmers/view/screens/onboard/onboardscreen.dart';
import 'package:e_agri_farmers/view/screens/onboard/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'helper/see_image.dart';
import 'localization/lang_constants.dart';
import 'localization/localization.dart';
import 'view/screens/buyer/buyer_dashboard/add_crop_demand_buyer/add_demand_screen.dart';
import 'view/screens/buyer/buyer_dashboard/home_tab_buyer/send_offer_to_farmer/send_offer_to_farmer_screen.dart';
import 'view/screens/buyer/buyer_dashboard/trade_tab_buyer/recent_bids_of_buyer/recend_bids_screen.dart';
import 'view/screens/farmer/farmer_dashboard/add_crop_for_sell/add_crop_screen.dart';
import 'view/screens/farmer/farmer_dashboard/farmer_home_tab/send_bid_to_buyer/send_offer_to_buyer_screen.dart';
import 'view/screens/farmer/farmer_dashboard/farmer_trade_tab/recent_bids_of_farmer/recend_bids.dart';
import 'view/screens/settingScreen/settings_screen.dart';

// to change lang use  this code from anywhere in class
//
// void _changeLanguage(Language language) async {
//   Locale _locale = await setLocale(language.languageCode);
//   MyApp.setLocale(context, _locale);
// }



void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    if (_locale == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: "Flutter Localization Demo",
        theme: ThemeData(primarySwatch: Colors.blue),
        locale: _locale,
        supportedLocales: const [
          Locale("en" , "US"),
          Locale("mr" , "IN"),
          Locale("hi" , "IN"),
          Locale("ta" , "IN"),
          Locale("pa" , "IN")
        ],
        localizationsDelegates: const [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        routes: {
          RoutePaths.generalController : (ctx) => const GeneralController(),
          RoutePaths.cropType : (ctx) => const CropTypes(),
          RoutePaths.schemaScreen : (ctx) => const SchemaScreen(),
          RoutePaths.schemaDetailScreen : (ctx) => const SchemaDetailScreen(),
          RoutePaths.techScreen : (ctx) => const TechScreen(),
          RoutePaths.techDetailScreen : (ctx) => const TechDetailScreen(),

          RoutePaths.onBoardScreen : (context) => const OnBoardScreen(),
          RoutePaths.chooseType : (context) => const ChooseType(),
          RoutePaths.registerFarmer : (ctx) => const FarmerRegisterScreen(),
          RoutePaths.verifyFarmer : (ctx) => const FarmerVerifyOTP(),
          RoutePaths.registerBuyer : (ctx) => const BuyerRegister(),
          RoutePaths.verifyBuyer : (ctx) => const BuyerVerify(),
          RoutePaths.loginBuyer : (ctx) => const BuyerLoginScreen(),
          RoutePaths.verifyBuyerLogin : (ctx) => const VerifyBuyerLogin(),
          RoutePaths.loginFarmer : (ctx) => const FarmerLoginScreen(),
          RoutePaths.verifyFarmerLogin : (ctx) => const VerifyFarmerLogin(),

          RoutePaths.splashScreen : (ctx) => const SplashScreen(),
          RoutePaths.buyerDashboardController : (ctx) => const BuyerDashboardController(),
          RoutePaths.addDemandScreen : (ctx) => const AddDemandScreen(),
          RoutePaths.sendOfferToFarmer : (ctx) => const SendOfferToFarmerScreen(),
          RoutePaths.recentBidsBuyer : (ctx) => const RecentBidInfoBuyer(),
          RoutePaths.farmerDashboardController : (ctx) => const FarmerDashboardController(),
          RoutePaths.addCropScreen : (ctx) => const AddCropScreenFarmer(),
          RoutePaths.sendOfferToBuyer : (ctx) => const SendOfferToBuyerScreen(),
          RoutePaths.recentBidsFarmer : (ctx) => const RecentBidOfFarmerScreen(),
          RoutePaths.seeCertificateImage : (ctx) => const SeeImage(),
          RoutePaths.settings : (ctx) => const SettingScreen()
          // RoutePaths.auctionFullData : (ctx) => const AuctionDetails(),

        },
        initialRoute: RoutePaths.splashScreen,
      );
    }
  }
}

