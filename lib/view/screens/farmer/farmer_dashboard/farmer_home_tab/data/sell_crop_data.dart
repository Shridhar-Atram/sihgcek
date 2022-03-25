import 'dart:convert';

SellCropDataFarmer sellCropDataFromJson(String str) => SellCropDataFarmer.fromJson(json.decode(str));

String sellCropDataToJson(SellCropDataFarmer data) => json.encode(data.toJson());

class SellCropDataFarmer {
  SellCropDataFarmer({
    required this.certificateUrl,
    required this.farmerName,
    required this.transport,
    required this.auctionID,
    required this.cropName,
    required this.totalQuantity,
    required this.minimumQuantity,
    required this.offerperUnit,
    required this.variety,
    required this.village,
    required this.state,
    required this.district,
    required this.farmerId,
  });

  String certificateUrl;
  bool transport;
  String auctionID;
  String cropName;
  int totalQuantity;
  int minimumQuantity;
  int offerperUnit;
  String variety;
  String village;
  String state;
  String district;
  String farmerId;
  String farmerName;
  factory SellCropDataFarmer.fromJson(Map<String, dynamic> json) => SellCropDataFarmer(
    certificateUrl: json["certificateURL"]??"",
    farmerName : json["farmerName"]??"",
    transport: json["transport"]??false,
    auctionID: json["auctionID"]??"",
    cropName: json["cropName"]??"",
    totalQuantity: json["totalQuantity"]??0,
    minimumQuantity: json["minimumQuantity"]??0,
    offerperUnit: json["offerperUnit"]??0,
    variety: json["variety"]??"",
    village: json["village"]??"",
    state: json["state"]??"",
    district: json["district"]??"",
    farmerId: json["farmerID"]??"",
  );

  Map<String, dynamic> toJson() => {
    "certificateURL": certificateUrl,
    "transport": transport,
    "auctionID": auctionID,
    "cropName": cropName,
    "totalQuantity": totalQuantity,
    "minimumQuantity": minimumQuantity,
    "offerperUnit": offerperUnit,
    "variety": variety,
    "village": village,
    "state": state,
    "district": district,
    "farmerID": farmerId,
    "farmerName" : farmerName
  };
}
