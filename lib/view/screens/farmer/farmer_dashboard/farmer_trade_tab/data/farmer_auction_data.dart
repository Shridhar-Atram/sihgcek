class FarmerAuctionData {
  FarmerAuctionData(
      {required this.auctionID,
        required this.certificateURL,
        required this.cropName,
        required this.district,
        required this.farmerID,
        required this.farmerName,
        required this.minimumQuantity,
        required this.offerperUnit,
        required this.state,
        required this.totalQuantity,
        required this.transport,
        required this.variety,
        required this.village});

  String auctionID;
  String certificateURL;
  String cropName;
  String district;
  String farmerID;
  String farmerName;
  int minimumQuantity;
  int offerperUnit;
  String state;
  int totalQuantity;
  bool transport;
  String variety;
  String village;



  factory FarmerAuctionData.fromJson(Map<String, dynamic> json) =>FarmerAuctionData(auctionID : json['auctionID']??"",
      certificateURL : json['certificateURL']??"",
      cropName : json['cropName']??"",
      district : json['district']??"",
      farmerID : json['farmerID']??"",
      farmerName : json['farmerName']??"",
      minimumQuantity : json['minimumQuantity']??0,
      offerperUnit : json['offerperUnit']??0,
      state : json['state']??"",
      totalQuantity : json['totalQuantity']??0,
      transport : json['transport']??false,
      variety : json['variety']??"",
      village : json['village']??"",);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auctionID'] = auctionID;
    data['certificateURL'] = certificateURL;
    data['cropName'] = cropName;
    data['district'] = district;
    data['farmerID'] = farmerID;
    data['farmerName'] = farmerName;
    data['minimumQuantity'] = minimumQuantity;
    data['offerperUnit'] = offerperUnit;
    data['state'] = state;
    data['totalQuantity'] = totalQuantity;
    data['transport'] = transport;
    data['variety'] = variety;
    data['village'] = village;
    return data;
  }
}