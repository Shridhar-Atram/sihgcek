// To parse this JSON data, do
//
//     final recentBidDataBuyer = recentBidDataBuyerFromJson(jsonString);

import 'dart:convert';

SchemaData recentBidDataBuyerFromJson(String str) => SchemaData.fromJson(json.decode(str));

String recentBidDataBuyerToJson(SchemaData data) => json.encode(data.toJson());

class SchemaData {
  SchemaData({
    required this.benefit,
    required this.docs,
    required this.eligiblity,
    required this.link,
    required this.overview,
    required this.scheme,

  });

  String benefit;
  String docs;
  String eligiblity;
  String link ;
  String overview;
  String scheme;

  factory SchemaData.fromJson(Map<String, dynamic> json) => SchemaData(
    benefit: json["benefit"]??"NULL",
    docs: json["docs"]??"NULL",
    eligiblity:json["eligiblity"]??"NULL",
    link: json["link"]??"NULL",
    overview: json["overview"]??"NULL",
    scheme: json["scheme"]??"NULL",
  );

  Map<String, dynamic> toJson() => {
    "benefit": benefit,
    "docs": docs,
    "eligiblity": eligiblity,
    "link": link,
    "overview": overview,
    "scheme": scheme,
  };
}
