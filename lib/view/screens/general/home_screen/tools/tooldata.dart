// To parse this JSON data, do
//
//     final recentBidDataBuyer = recentBidDataBuyerFromJson(jsonString);

import 'dart:convert';

ToolData recentBidDataBuyerFromJson(String str) => ToolData.fromJson(json.decode(str));

String recentBidDataBuyerToJson(ToolData data) => json.encode(data.toJson());

class ToolData {
  ToolData({
    required this.features,
    required this.name,
    required this.image_link,
    required this.source,
    required this.uses,

  });

  String features;
  String name;
  String image_link;
  String source ;
  String uses;


  factory ToolData.fromJson(Map<String, dynamic> json) => ToolData(
    features: json["features"]??"NULL",
    name: json["name"]??"NULL",
    image_link:json["image_link"]??"NULL",
    source: json["source"]??"NULL",
    uses: json["uses"]??"NULL",
  );

  Map<String, dynamic> toJson() => {
    "features": features,
    "name": name,
    "image_link": image_link,
    "source": source,
    "uses":uses
  };
}
