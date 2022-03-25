
import 'dart:convert';

AcceptedBidScreenData auctionFullDataBuyerFromJson(String str) => AcceptedBidScreenData.fromJson(json.decode(str));

String auctionFullDataBuyerToJson(AcceptedBidScreenData data) => json.encode(data.toJson());

class AcceptedBidScreenData {
  AcceptedBidScreenData({
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
    required this.buyerName,
  });

  String auctionId;
  String buyerName;
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

  factory AcceptedBidScreenData.fromJson(Map<String, dynamic> json) => AcceptedBidScreenData(
    auctionId: json["auctionID"],
    buyerName : json["buyerName"]??"NULL",
    buyerId: json["buyerID"],
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
    "buyerName": buyerName,
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
