// To parse this JSON data, do
//
//     final buyerAuctionData = buyerAuctionDataFromJson(jsonString);

import 'dart:convert';

BuyerAuctionData buyerAuctionDataFromJson(String str) => BuyerAuctionData.fromJson(json.decode(str));

String buyerAuctionDataToJson(BuyerAuctionData data) => json.encode(data.toJson());

class BuyerAuctionData {
  BuyerAuctionData({
    required this.auctionId,
    required this.buyerId,
    required this.cropName,
    required this.district,
    required this.minimumQuantity,
    required this.offerperUnit,
    required this.state,
    required this.totalQuantity,
    required this.variety,
    required this.village,
    required this.buyerName,

  });

  String auctionId;
  String buyerId;
  String cropName;
  String district;
  int minimumQuantity;
  int offerperUnit;
  String state;
  int totalQuantity;
  String variety;
  String village;
  String buyerName;

  factory BuyerAuctionData.fromJson(Map<String, dynamic> json) => BuyerAuctionData(
    auctionId: json["auctionID"]??"1",
    buyerId: json["buyerID"],
    cropName: json["cropName"],
    district: json["district"],
    minimumQuantity: json["minimumQuantity"],
    offerperUnit: json["offerperUnit"],
    state: json["state"],
    totalQuantity: json["totalQuantity"],
    variety: json["variety"],
    village: json["village"],
    buyerName: json["buyerName"],

  );

  Map<String, dynamic> toJson() => {
    "auctionID": auctionId,
    "buyerID": buyerId,
    "cropName": cropName,
    "district": district,
    "minimumQuantity": minimumQuantity,
    "offerperUnit": offerperUnit,
    "state": state,
    "totalQuantity": totalQuantity,
    "variety": variety,
    "village": village,
    "buyerName": buyerName,

  };
}
