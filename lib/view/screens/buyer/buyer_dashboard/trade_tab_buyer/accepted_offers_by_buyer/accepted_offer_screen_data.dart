
import 'dart:convert';

AcceptedOfferBuyerData auctionFullDataBuyerFromJson(String str) => AcceptedOfferBuyerData.fromJson(json.decode(str));

String auctionFullDataBuyerToJson(AcceptedOfferBuyerData data) => json.encode(data.toJson());

class AcceptedOfferBuyerData {
  AcceptedOfferBuyerData({
    required this.auctionId,
    required this.buyerId,
    required this.farmerName,
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
  });

  String auctionId;
  String farmerName;
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

  factory AcceptedOfferBuyerData.fromJson(Map<String, dynamic> json) => AcceptedOfferBuyerData(
    auctionId: json["auctionID"],
    buyerId: json["buyerID"],
    farmerName: json["farmerName"]??"NULL",
    certificateUrl: json["certificateURL"],
    cropName: json["cropName"],
    district: json["district"],
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
    "farmerName": farmerName,
    "minimumQuantity": minimumQuantity,
    "offerperUnit": offerperUnit,
    "offerperUnitAsked": offerperUnitAsked,
    "quantityAsked": quantityAsked,
    "state": state,
    "totalQuantity": totalQuantity,
    "variety": variety,
    "village": village,
  };
}
