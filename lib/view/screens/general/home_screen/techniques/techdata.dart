// To parse this JSON data, do
//
//     final recentBidDataBuyer = recentBidDataBuyerFromJson(jsonString);

import 'dart:convert';

TechData recentBidDataBuyerFromJson(String str) => TechData.fromJson(json.decode(str));

String recentBidDataBuyerToJson(TechData data) => json.encode(data.toJson());

class TechData {
  TechData({
    required this.desc,
    required this.tech,
    required this.type,
    required this.type_desc,


  });

  String desc;
  String tech;
  String type;
  String type_desc ;


  factory TechData.fromJson(Map<String, dynamic> json) => TechData(
    desc: json["desc"]??"NULL",
    tech: json["tech"]??"NULL",
    type:json["type"]??"NULL",
    type_desc: json["type_desc"]??"NULL",
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "tech": tech,
    "type": type,
    "type_desc": type_desc,
  };
}
