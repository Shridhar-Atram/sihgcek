class AuctionFullDataFarmer {
  String auctionID;
  String buyerName;
  String buyerID;
  String certificateURL;
  String cropName;
  String district;
  String farmerID;
  String farmerName;
  int minimumQuantity;
  int offerperUnit;
  int offerperUnitAsked;
  int quantityAsked;
  String state;
  int totalQuantity;
  bool transport;
  String variety;
  String village;

  AuctionFullDataFarmer(
      {required this.auctionID,
       required this.buyerName,
       required this.buyerID,
       required this.certificateURL,
       required this.cropName,
       required this.district,
       required this.farmerID,
       required this.farmerName,
       required this.minimumQuantity,
       required this.offerperUnit,
       required this.offerperUnitAsked,
       required this.quantityAsked,
       required this.state,
       required this.totalQuantity,
       required this.transport,
       required this.variety,
       required this.village});

  factory AuctionFullDataFarmer.fromJson(Map<String, dynamic> json) => AuctionFullDataFarmer(
    auctionID : json['auctionID'],
    buyerID : json['buyerID'],
    buyerName : json["buyerName"]??"NULL",
    certificateURL : json['certificateURL'],
    cropName : json['cropName'],
    district : json['district'],
    farmerID : json['farmerID'],
    farmerName : json['farmerName'],
    minimumQuantity : json['minimumQuantity'],
    offerperUnit : json['offerperUnit'],
    offerperUnitAsked : json['offerperUnitAsked'],
    quantityAsked : json['quantityAsked'],
    state : json['state'],
    totalQuantity : json['totalQuantity'],
    transport : json['transport'],
    variety : json['variety'],
    village : json['village'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auctionID'] =auctionID;
    data['buyerID'] = buyerID;
    data['certificateURL'] = certificateURL;
    data["buyerName"] = buyerName;
    data['cropName'] = cropName;
    data['district'] = district;
    data['farmerID'] = farmerID;
    data['farmerName'] = farmerName;
    data['minimumQuantity'] = minimumQuantity;
    data['offerperUnit'] = offerperUnit;
    data['offerperUnitAsked'] = offerperUnitAsked;
    data['quantityAsked'] = quantityAsked;
    data['state'] = state;
    data['totalQuantity'] = totalQuantity;
    data['transport'] = transport;
    data['variety'] = variety;
    data['village'] = village;
    return data;
  }
}