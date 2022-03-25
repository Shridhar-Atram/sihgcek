// To parse this JSON data, do
//
//     final auctionFullDataBuyer = auctionFullDataBuyerFromJson(jsonString);

import 'dart:convert';

AuctionFullDataBuyer auctionFullDataBuyerFromJson(String str) => AuctionFullDataBuyer.fromJson(json.decode(str));

String auctionFullDataBuyerToJson(AuctionFullDataBuyer data) => json.encode(data.toJson());

class AuctionFullDataBuyer {
  AuctionFullDataBuyer({
    required this.auctionId,
    required this.buyerId,
    required this.certificateUrl,
    required this.cropName,
    required this.district,
    required this.farmerId,
    required this.minimumQuantity,
    required this.offerperUnit,
    required this.offerperUnitAsked,
    required this.quantityAsked,
    required this.state,
    required this.totalQuantity,
    required this.variety,
    required this.village,
    required this.farmerName,
  });

  String auctionId;
  String buyerId;
  String certificateUrl;
  String cropName;
  String district;
  String farmerId;
  int minimumQuantity;
  int offerperUnit;
  int offerperUnitAsked;
  int quantityAsked;
  String state;
  int totalQuantity;
  String variety;
  String village;
  String farmerName;

  factory AuctionFullDataBuyer.fromJson(Map<String, dynamic> json) => AuctionFullDataBuyer(
    auctionId: json["auctionID"],
    buyerId: json["buyerID"],
    certificateUrl: json["certificateURL"],
    cropName: json["cropName"],
    district: json["district"],
    farmerName: json["farmerName"]??"NULL",
    farmerId: json["farmerID"],
    minimumQuantity: json["minimumQuantity"],
    offerperUnit: json["offerperUnit"],
    offerperUnitAsked: json["offerperUnitAsked"],
    quantityAsked: json["quantityAsked"],
    state: json["state"],
    totalQuantity: json["totalQuantity"],
    variety: json["variety"],
    village: json["village"],
  );

  Map<String, dynamic> toJson() => {
    "auctionID": auctionId,
    "buyerID": buyerId,
    "certificateURL": certificateUrl,
    "cropName": cropName,
    "district": district,
    "farmerID": farmerId,
    "minimumQuantity": minimumQuantity,
    "offerperUnit": offerperUnit,
    "offerperUnitAsked": offerperUnitAsked,
    "quantityAsked": quantityAsked,
    "state": state,
    "totalQuantity": totalQuantity,
    "variety": variety,
    "village": village,
    "farmerName":farmerName,
  };
}
