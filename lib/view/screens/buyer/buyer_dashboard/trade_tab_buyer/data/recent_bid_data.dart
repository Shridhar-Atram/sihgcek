// To parse this JSON data, do
//
//     final recentBidDataBuyer = recentBidDataBuyerFromJson(jsonString);

import 'dart:convert';

RecentBidDataBuyer recentBidDataBuyerFromJson(String str) => RecentBidDataBuyer.fromJson(json.decode(str));

String recentBidDataBuyerToJson(RecentBidDataBuyer data) => json.encode(data.toJson());

class RecentBidDataBuyer {
  RecentBidDataBuyer({
    required this.auctionId,
    required this.farmerName,
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
    required this.transport,
    required this.variety,
    required this.village,
    required this.buyerName,
  });

  String auctionId;
  String buyerId;
  String certificateUrl;
  String cropName;
  String district;
  String farmerId;
  int minimumQuantity;
  int offerperUnit;
  String farmerName;
  int offerperUnitAsked;
  int quantityAsked;
  String state;
  int totalQuantity;
  bool transport;
  String variety;
  String village;
  String buyerName;
  factory RecentBidDataBuyer.fromJson(Map<String, dynamic> json) => RecentBidDataBuyer(
    auctionId: json["auctionID"]??"NULL",
    buyerId: json["buyerID"]??"NULL",
    buyerName:json["buyerName"]??"NULL",
    certificateUrl: json["certificateURL"]??"NULL",
    cropName: json["cropName"]??"NULL",
    district: json["district"]??"NULL",
    farmerName: json["farmerName"]??"NULL",
    farmerId: json["farmerID"]??"NULL",
    minimumQuantity: json["minimumQuantity"]??"NULL",
    offerperUnit: json["offerperUnit"]??"NULL",
    offerperUnitAsked: json["offerperUnitAsked"]??"NULL",
    quantityAsked: json["quantityAsked"]??"NULL",
    state: json["state"]??"NULL",
    totalQuantity: json["totalQuantity"]??"NULL",
    transport: json["transport"]??"NULL",
    variety: json["variety"]??"NULL",
    village: json["village"]??"NULL",
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
    "transport": transport,
    "variety": variety,
    "farmerName":farmerName,
    "village": village,
    "buyerName":buyerName,
  };
}
