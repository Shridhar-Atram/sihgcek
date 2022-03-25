import 'dart:convert';

DemandCropDataFarmer sellCropDataFromJson(String str) => DemandCropDataFarmer.fromJson(json.decode(str));

String sellCropDataToJson(DemandCropDataFarmer data) => json.encode(data.toJson());

class DemandCropDataFarmer {
  DemandCropDataFarmer({
    required this.auctionID,
    required this.cropName,
    required this.totalQuantity,
    required this.variety,
    required this.village,
    required this.state,
    required this.district,
    required this.offerperUnit,
    required this.buyerId,
    required this.minimumQuantity,
    required this.buyerName,

  });
  String buyerName;
  String auctionID;
  String cropName;
  int totalQuantity;
  String variety;
  String village;
  String state;
  String district;
  int offerperUnit;
  String buyerId;
  int minimumQuantity;
  factory DemandCropDataFarmer.fromJson(Map<String, dynamic> json) => DemandCropDataFarmer(
    auctionID: json["auctionID"]??"",
    cropName: json["cropName"]??"",
    totalQuantity: json["totalQuantity"]??0,
    variety: json["variety"]??"",
    village: json["village"]??"",
    state: json["state"]??"",
    district: json["district"]??"",
    offerperUnit: json["offerperUnit"]??0,
    buyerId: json["buyerID"]??"",
    minimumQuantity: json["minimumQuantity"],
    buyerName: json["buyerName"],

  );

  Map<String, dynamic> toJson() => {
    "auctionID": auctionID,
    "cropName": cropName,
    "totalQuantity": totalQuantity,
    "variety": variety,
    "village": village,
    "state": state,
    "district": district,
    "offerperUnit": offerperUnit,
    "buyerID": buyerId,
    "minimumQuantity" :minimumQuantity,
    "buyerName" :buyerName

  };
}
