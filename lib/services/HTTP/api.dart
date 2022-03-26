import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/current_logged_buyer/current_user.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/trade_tab_buyer/hosted_auction_by_buyer/data/auction_data.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/current_farmer/current_user.dart';
import 'package:e_agri_farmers/view/screens/farmer/farmer_dashboard/farmer_trade_tab/auction_hosted_by_farmer/data/auction_data.dart';

import 'http.dart';

class API {
  static String baseurl = "https://eagribackend.herokuapp.com";
  static String allSellCrops = baseurl + "/api/sell/auction/all";
  static String allDemandCrops = baseurl + "/api/demand/auction/all";
  static String createBuyer = baseurl + "/api/buyer/signup";
  static String createFarmer = baseurl + "/api/farmer/signup";
  static String loginBuyer = baseurl + "/api/buyer/signin/mobile";
  static String loginFarmer = baseurl + "/api/farmer/signin/mobile";
  static String addDemand = baseurl + "/api/demand/auction/add";
  static String acceptBidBuyerApi = baseurl + "/api/demand/auction/update/bid";
  static String acceptBidFarmerApi = baseurl + "/api/sell/auction/update/bid";
  static String acceptedBidFarmer =
      baseurl + "/api/demand/auction/accepted/bid";
  static String acceptedOfferFarmer = baseurl + "/api/sell/auction/accepted";
  static String acceptedBidBuyer = baseurl + "/api/sell/auction/accepted/bid";
  static String acceptedOfferBuyer = baseurl + "/api/demand/auction/accepted";

  static String addCrop = baseurl + "/api/sell/auction/add";
  static String tradeScreenBuyer = baseurl + "/api/buyer/trade/data";
  static String tradeScreenFarmer = baseurl + "/api/farmer/trade/data";
  static String addBidBuyer = baseurl + "/api/sell/auction/add/bid";
  static String addBidFarmer = baseurl + "/api/demand/auction/add/bid";
  static String auctionData = baseurl + "/api/demand/auction/bid/";
  static String auctionDataFarmer = baseurl + "/api/sell/auction/bid/";
}


dynamic predictCrop({required dynamic data}) async {
  try {
    var x  = await HTTP.postHttpRes("https://cropitup.herokuapp.com/login", data);
    final pp = json.decode(x.body);
    // print(pp.toString());
    return pp;
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

dynamic getAuctionData(String auctionID) async {
  return await HTTP.getHttpRes(Uri.encodeFull(API.auctionData + auctionID));
}

dynamic getAuctionDataFarmer(String auctionID) async {
  return await HTTP
      .getHttpRes(Uri.encodeFull(API.auctionDataFarmer + auctionID));
}

dynamic getSellCropData() async {
  return await HTTP.getHttpRes(API.allSellCrops);
}

dynamic getDemandCropData() async {
  return await HTTP.getHttpRes(API.allDemandCrops);
}



dynamic tradeScreenBuyer({required String buyerID}) async {
  try {
    return await HTTP.postHttpRes(API.tradeScreenBuyer, {
      "buyerID": buyerID,
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

dynamic tradeScreenFarmer({required String farmerID}) async {
  try {
    return await HTTP.postHttpRes(API.tradeScreenFarmer, {
      "farmerID": farmerID,
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

dynamic acceptedBidFarmer({required String farmerID}) async {
  try {
    return await HTTP.postHttpRes(API.acceptedBidFarmer, {
      "farmerID": farmerID,
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

dynamic acceptedOfferFarmer({required String farmerID}) async {
  try {
    return await HTTP.postHttpRes(API.acceptedOfferFarmer, {
      "farmerID": farmerID,
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

dynamic acceptedBidBuyer({required String buyerId}) async {
  try {
    return await HTTP.postHttpRes(API.acceptedBidBuyer, {
      "buyerID": buyerId,
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

dynamic acceptedOfferBuyer({required String buyerId}) async {
  try {
    return await HTTP.postHttpRes(API.acceptedOfferBuyer, {
      "buyerID": buyerId,
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

Future<bool> addBidBuyer(Map<String, dynamic> data) async {
  try {
    PP.p(data.toString());
    return FirebaseFirestore.instance
        .collection("buyers")
        .doc(CurrentBuyerUser.buyerID)
        .collection("bids")
        .doc(data["auctionID"])
        .set(data)
        .then((value) => FirebaseFirestore.instance
            .collection("farmers")
            .doc(data["farmerID"])
            .collection("auctions")
            .doc(data["auctionID"])
            .collection("bids")
            .doc(CurrentBuyerUser.buyerID)
            .set(data)
            .then((value) => FirebaseFirestore.instance
                .collection("crops")
                .doc(data["auctionID"])
                .collection("bids")
                .doc("users")
                .set(
                  {CurrentBuyerUser.buyerID: true},
                  SetOptions(merge: true),
                )
                .then((value) => true)
                .onError((error, stackTrace) => false))
            .onError((error, stackTrace) => false))
        .onError((error, stackTrace) => false);
  } on SocketException {
    PP.p("noic");
    return false;
  } catch (e) {
    PP.p("--->" + e.toString());
    return false;
  }
}

Future<bool> addBidFarmer(var data) async {
  try {
    PP.p(data.toString());
    return FirebaseFirestore.instance
        .collection("farmers")
        .doc(CurrentFarmerUser.farmerID)
        .collection("bids")
        .doc(data["auctionID"])
        .set(data)
        .then((value) => FirebaseFirestore.instance
            .collection("buyers")
            .doc(data["buyerID"])
            .collection("auctions")
            .doc(data["auctionID"])
            .collection("bids")
            .doc(CurrentFarmerUser.farmerID)
            .set(data)
            .then((value) => FirebaseFirestore.instance
                .collection("demands")
                .doc(data["auctionID"])
                .collection("bids")
                .doc("users")
                .set(
                  {CurrentFarmerUser.farmerID: true},
                  SetOptions(merge: true),
                )
                .then((value) => true)
                .onError((error, stackTrace) => false))
            .onError((error, stackTrace) => false))
        .onError((error, stackTrace) => false);
  } on SocketException {
    PP.p("noic");
    return false;
  } catch (e) {
    PP.p("--->" + e.toString());
    return false;
  }
}

dynamic registerBuyer(
    {required String name,
    required String aadharCard,
    required String contactNo,
    required String emailId,
    required String role,
    required String address,
    required String panNo,
    required String gstNo,
    required String compnyName,
    required String password}) async {
  try {
    return await HTTP.postHttpRes(API.createBuyer, {
      "name": name,
      "adhaarCard": aadharCard,
      "contactNo": contactNo,
      "emailId": emailId,
      "role": role,
      "address": address,
      "panNo": panNo,
      "gstNo": gstNo,
      "companyName": compnyName,
      "password": password
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

Future<String> registerBuyerToFirebase(
    {required String name,
    required String aadharCard,
    required String contactNo,
    required String emailId,
    required String role,
    required String address,
    required String panNo,
    required String gstNo,
    required String compnyName,
    required String password}) async {
  var result = "ERROR";
  try {
    var data = {
      "buyerName": name,
      "adhaarCard": aadharCard,
      "contactNo": contactNo,
      "emailId": emailId,
      "role": role,
      "address": address,
      "panNo": panNo,
      "gstNo": gstNo,
      "companyName": compnyName,
      "password": password
    };
    result = await FirebaseFirestore.instance
        .collection("buyers")
        .doc(contactNo)
        .set(data)
        .then((value) {
      return "done";
    }).catchError((err) {
      PP.p(err.toString());
      return "err";
    });
  } on SocketException {
    PP.p("Socket Exception NOIC");
    return "NOIC";
  } catch (e) {
    PP.p(e.toString());
    return e.toString();
  }
  return result.toString();
}

dynamic registerFarmer(
    {required String name,
    required String aadharCard,
    required String contactNo,
    required String emailId,
    required String address,
    required String shopName,
    required String password}) async {
  try {
    return await HTTP.postHttpRes(API.createFarmer, {
      "name": name,
      "adhaarCard": aadharCard,
      "contactNo": contactNo,
      "emailId": emailId,
      "address": address,
      "shopName": shopName,
      "password": password
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

Future<String> registerFarmerToFirebase(
    {required String name,
    required String aadharCard,
    required String contactNo,
    required String emailId,
    required String address,
    required String shopName,
    required String password}) async {
  var result = "ERROR";
  try {
    var data = {
      "farmerName": name,
      "adhaarCard": aadharCard,
      "contactNo": contactNo,
      "emailId": emailId,
      "address": address,
      "shopName": shopName,
      "password": password
    };
    result = await FirebaseFirestore.instance
        .collection("farmers")
        .doc(contactNo)
        .set(data)
        .then((value) {
      return "done";
    }).catchError((err) {
      PP.p(err.toString());
      return "err";
    });
  } on SocketException {
    PP.p("Socket Exception NOIC");
    return "NOIC";
  } catch (e) {
    PP.p(e.toString());
    return e.toString();
  }
  return result.toString();
}

dynamic addCropForSellAPI({
  required String farmerID,
  required String cropName,
  required int totalQuantity,
  required int minimumQuantity,
  required int offerperUnit,
  required int startDate,
  required int endDate,
  required String variety,
  required int transportCost,
  required bool transport,
  required String district,
  required String state,
  required String village,
  required String certificateURL,
}) async {
  try {
    return await HTTP.postHttpRes(API.addCrop, {
      "farmerID": farmerID,
      "cropName": cropName,
      "totalQuantity": totalQuantity,
      "minimumQuantity": minimumQuantity,
      "offerperUnit": offerperUnit,
      "variety": variety,
      "village": village,
      "state": state,
      "district": district,
      "transport": transport,
      "transportCost": transportCost,
      "startDate": startDate,
      "endDate": endDate,
      "certificateURL": certificateURL
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

Future<bool> addCropForSellAPIToFirebase({
  required String farmerID,
  required String cropName,
  required int totalQuantity,
  required int minimumQuantity,
  required int offerperUnit,
  required int startDate,
  required int endDate,
  required String variety,
  required bool transport,
  required String district,
  required String state,
  required String village,
  required String certificateURL,
  required String farmerName,
  required String auctionId,
}) async {
  try {
    var data = {
      "farmerName": farmerName,
      "auctionID": auctionId,
      "farmerID": farmerID,
      "cropName": cropName,
      "totalQuantity": totalQuantity,
      "minimumQuantity": minimumQuantity,
      "offerperUnit": offerperUnit,
      "variety": variety,
      "village": village,
      "state": state,
      "district": district,
      "transport": transport,
      "certificateURL": certificateURL
    };

    return await FirebaseFirestore.instance
        .collection("farmers")
        .doc(farmerID)
        .collection("auctions")
        .doc(auctionId)
        .set(data)
        .then((value) async {
      return await FirebaseFirestore.instance
          .collection("crops")
          .doc(auctionId)
          .set(data)
          .then((value) {
        return true;
      }).catchError((err) {
        PP.p(err.toString());
        return false;
      });
    }).catchError((err) {
      PP.p(err.toString());
      return false;
    });
  } on SocketException {
    PP.p("noic");
    return false;
  } catch (e) {
    PP.p(e.toString());
    return false;
  }
}

dynamic addDemandOfCrop({
  required String buyerID,
  required String cropName,
  required int totalQuantity,
  required int minimumQuantity,
  required String variety,
  required String village,
  required String state,
  required String district,
  required int offerperUnit,
  required dynamic startDate,
  required dynamic endDate,
}) async {
  try {
    return await HTTP.postHttpRes(API.addDemand, {
      "buyerID": buyerID,
      "cropName": cropName,
      "totalQuantity": totalQuantity,
      "minimumQuantity": minimumQuantity,
      "variety": variety,
      "village": village,
      "state": state,
      "district": district,
      "offerperUnit": offerperUnit,
      "startDate": startDate,
      "endDate": endDate
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

Future<bool> addDemandOfCropToFirebase({
  required String buyerID,
  required String cropName,
  required int totalQuantity,
  required int minimumQuantity,
  required String variety,
  required String village,
  required String state,
  required String district,
  required int offerperUnit,
  required String auctionID,
  required String buyerName,
}) async {
  try {
    var data = {
      "auctionID": auctionID,
      "buyerName": buyerName,
      "buyerID": buyerID,
      "cropName": cropName,
      "totalQuantity": totalQuantity,
      "minimumQuantity": minimumQuantity,
      "variety": variety,
      "village": village,
      "state": state,
      "district": district,
      "offerperUnit": offerperUnit,
    };
    return await FirebaseFirestore.instance
        .collection("buyers")
        .doc(buyerID)
        .collection("auctions")
        .doc(auctionID)
        .set(data)
        .then((value) async {
      return await FirebaseFirestore.instance
          .collection("demands")
          .doc(auctionID)
          .set(data)
          .then((value) {
        return true;
      }).catchError((err) {
        PP.p(err.toString());
        return false;
      });
    }).catchError((err) {
      PP.p(err.toString());
      return false;
    });
  } on SocketException {
    PP.p("noic");
    return false;
  } catch (e) {
    PP.p(e.toString());
    return false;
  }
}

dynamic updateBidBuyer({
  required AuctionFullDataBuyer auctionFullData,
}) async {
  try {
    bool flag = false;
    Map<String, dynamic>? users;

    flag = await FirebaseFirestore.instance
        .collection("demands")
        .doc(auctionFullData.auctionId)
        .collection("bids")
        .doc("users")
        .get()
        .then((value) {
      users = value.data();
      return false;
    }).catchError((err) {
      PP.p(err.toString());
      return true;
    });

    if (flag) return "noic1";

    users?.forEach((key, value) async {
      flag = await FirebaseFirestore.instance
          .collection("farmers")
          .doc(key.toString())
          .collection("bids")
          .doc(auctionFullData.auctionId)
          .delete()
          .then((value) => false)
          .catchError((err) {
        PP.p("1" + err.toString());
        return true;
      });
    });

    if (flag) return "noic2";

    flag = await FirebaseFirestore.instance
        .collection("demands")
        .doc(auctionFullData.auctionId)
        .delete()
        .then((value) => false)
        .catchError((err) {
      PP.p("2" + err.toString());
      return true;
    });

    if (flag) return "noic3";

    flag = await FirebaseFirestore.instance
        .collection("buyers")
        .doc(auctionFullData.buyerId)
        .collection("auctions")
        .doc(auctionFullData.auctionId)
        .delete()
        .then((value) => false)
        .catchError((err) {
      PP.p("3" + err.toString());
      return true;
    });

    if (flag) return "noic4";

    flag = await FirebaseFirestore.instance
        .collection("buyers")
        .doc(auctionFullData.buyerId)
        .collection("my_previous_auctions")
        .doc(auctionFullData.auctionId)
        .set(auctionFullData.toJson())
        .then((value) => false)
        .catchError((err) {
      PP.p(err.toString());
      return true;
    });

    if (flag) return "noic5";

    flag = await FirebaseFirestore.instance
        .collection("farmers")
        .doc(auctionFullData.farmerId)
        .collection("my_previous_bids")
        .doc(auctionFullData.auctionId)
        .set(auctionFullData.toJson())
        .then((value) => false)
        .catchError((err) {
      PP.p(err.toString());
      return true;
    });

    if (flag) return "noic6";

    return "done";
  } on SocketException {
    return "noic7";
  } catch (e) {
    PP.p(e.toString());
    return "noic8";
  }
}

dynamic updateBidFarmer({
  required AuctionFullDataFarmer auctionFullData,
}) async {
  try {
    bool flag = false;
    Map<String, dynamic>? users;

    flag = await FirebaseFirestore.instance
        .collection("crops")
        .doc(auctionFullData.auctionID)
        .collection("bids")
        .doc("users")
        .get()
        .then((value) {
      users = value.data();
      return false;
    }).catchError((err) {
      PP.p(err.toString());
      return true;
    });

    if (flag) return "noic1";

    users?.forEach((key, value) async {
      flag = await FirebaseFirestore.instance
          .collection("buyers")
          .doc(key.toString())
          .collection("bids")
          .doc(auctionFullData.auctionID)
          .delete()
          .then((value) => false)
          .catchError((err) {
        PP.p("1" + err.toString());
        return true;
      });
    });

    if (flag) return "noic2";

    flag = await FirebaseFirestore.instance
        .collection("crops")
        .doc(auctionFullData.auctionID)
        .delete()
        .then((value) => false)
        .catchError((err) {
      PP.p("2" + err.toString());
      return true;
    });

    if (flag) return "noic3";

    flag = await FirebaseFirestore.instance
        .collection("farmers")
        .doc(auctionFullData.farmerID)
        .collection("auctions")
        .doc(auctionFullData.auctionID)
        .delete()
        .then((value) => false)
        .catchError((err) {
      PP.p("3" + err.toString());
      return true;
    });

    if (flag) return "noic4";

    flag = await FirebaseFirestore.instance
        .collection("farmers")
        .doc(auctionFullData.farmerID)
        .collection("my_previous_auctions")
        .doc(auctionFullData.auctionID)
        .set(auctionFullData.toJson())
        .then((value) => false)
        .catchError((err) {
      PP.p(err.toString());
      return true;
    });

    if (flag) return "noic5";

    flag = await FirebaseFirestore.instance
        .collection("buyers")
        .doc(auctionFullData.buyerID)
        .collection("my_previous_bids")
        .doc(auctionFullData.auctionID)
        .set(auctionFullData.toJson())
        .then((value) => false)
        .catchError((err) {
      PP.p(err.toString());
      return true;
    });

    if (flag) return "noic6";

    return "done";
  } on SocketException {
    return "noic7";
  } catch (e) {
    PP.p(e.toString());
    return "noic8";
  }
}

dynamic loginFarmer({required String contactNo}) async {
  try {
    return await HTTP.postHttpRes(API.loginFarmer, {
      "contactNo": contactNo,
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

Future<bool> loginFarmerToFirebase({required String contactNo}) async {
  try {
    return await FirebaseFirestore.instance
        .collection("farmers")
        .doc(contactNo)
        .get()
        .then((doc) {
      return doc.exists;
    });
  } on SocketException {
    PP.p("NOIC");
    return false;
  } catch (e) {
    PP.p(e.toString());
    return false;
  }
}

Future<bool> getAndSaveLoginDataFarmer({required String contactNo}) async {
  try {
    PP.p(contactNo);
    return await FirebaseFirestore.instance
        .collection('farmers')
        .doc(contactNo)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        PP.p('Document data: ${documentSnapshot.data()}');
        CurrentFarmerUser.farmerID = contactNo;
        CurrentFarmerUser.address = documentSnapshot.get("address");
        CurrentFarmerUser.name = documentSnapshot.get("farmerName");
        CurrentFarmerUser.shopName = documentSnapshot.get("shopName");
        CurrentFarmerUser.emailID = documentSnapshot.get("emailId");
        CurrentFarmerUser.contactNo = documentSnapshot.get("contactNo");
        CurrentFarmerUser.aadharCard = documentSnapshot.get("adhaarCard");
        return true;
      } else {
        PP.p('ERROR : Document does not exist on the database');
        return false;
      }
    });
  } catch (e) {
    PP.p(e.toString());
    return false;
  }
}

Future<bool> getAndSaveLoginDataBuyer({required String contactNo}) async {
  try {
    PP.p("getAndSaveLoginDataBuyer");
    return await FirebaseFirestore.instance
        .collection('buyers')
        .doc(contactNo)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        PP.p('Document data: ${documentSnapshot.data()}');
        CurrentBuyerUser.buyerID = contactNo;
        CurrentBuyerUser.role = documentSnapshot.get("role");
        CurrentBuyerUser.address = documentSnapshot.get("address");
        CurrentBuyerUser.panNo = documentSnapshot.get("panNo");
        CurrentBuyerUser.companyName = documentSnapshot.get("companyName");
        CurrentBuyerUser.name = documentSnapshot.get("buyerName");
        CurrentBuyerUser.gstNo = documentSnapshot.get("gstNo");
        CurrentBuyerUser.emailID = documentSnapshot.get("emailId");
        CurrentBuyerUser.adhaarCardNo = documentSnapshot.get("adhaarCard");
        CurrentBuyerUser.contactNo = documentSnapshot.get("contactNo");
        return true;
      } else {
        PP.p('ERROR : Document does not exist on the database');
        return false;
      }
    });
  } catch (e) {
    PP.p(e.toString());
    return false;
  }
}

dynamic loginBuyer({required String contactNo}) async {
  try {
    return await HTTP.postHttpRes(API.loginBuyer, {
      "contactNo": contactNo,
    });
  } on SocketException {
    return "noic";
  } catch (e) {
    PP.p(e.toString());
  }
  return;
}

Future<bool> loginBuyerToFirebase({required String contactNo}) async {
  try {
    return await FirebaseFirestore.instance
        .collection("buyers")
        .doc(contactNo)
        .get()
        .then((doc) {
      return doc.exists;
    });
  } on SocketException {
    PP.p("NOIC");
    return false;
  } catch (e) {
    PP.p(e.toString());
    return false;
  }
}
// dynamic updateUser({required dynamic json}) async {
//   PP.p(json.toString());
//   return await HTTP.putHttpRes(
//       API.updateUserUrl, json);
// }
//
