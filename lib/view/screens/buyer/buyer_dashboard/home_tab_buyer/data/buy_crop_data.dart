import 'dart:convert';

CropBuyDataBuyer sellCropDataFromJson(String str) => CropBuyDataBuyer.fromJson(json.decode(str));

String sellCropDataToJson(CropBuyDataBuyer data) => json.encode(data.toJson());

class CropBuyDataBuyer {
  CropBuyDataBuyer({
    required this.certificateUrl,
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
    required this.farmerName,
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

  factory CropBuyDataBuyer.fromJson(Map<String, dynamic> json) => CropBuyDataBuyer(
    certificateUrl: json["certificateURL"]??"",
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
    farmerName: json["farmerName"]??"",

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
    "farmerName": farmerName,

  };
}
