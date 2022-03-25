// // To parse this JSON data, do
// //
// //     final recentBidDataBuyer = recentBidDataBuyerFromJson(jsonString);
//
// import 'dart:convert';
//
// TechData recentBidDataBuyerFromJson(String str) => TechData.fromJson(json.decode(str));
//
// String recentBidDataBuyerToJson(TechData data) => json.encode(data.toJson());
//
// class TechData {
//   TechData({
//     required this.features,
//     required this.name,
//     required this.image_link,
//     required this.source,
//     required this.uses,
//
//   });
//
//   String features;
//   String name;
//   String image_link;
//   String source ;
//   String uses;
//
//
//   factory TechData.fromJson(Map<String, dynamic> json) => TechData(
//     features: json["features"]??"NULL",
//     image_link: json["image_link"]??"NULL",
//     name:json["name"]??"NULL",
//     source: json["source"]??"NULL",
//     source: json["source"]??"NULL",
//   );
//
//   Map<String, dynamic> toJson() => {
//     "desc": desc,
//     "tech": tech,
//     "type": type,
//     "type_desc": type_desc,
//   };
// }
