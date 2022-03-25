class RecentBidDataFarmer {
  String auctionID;
  String buyerID;
  String certificateURL;
  String cropName;
  String district;
  String farmerID;
  int minimumQuantity;
  int offerperUnit;
  int offerperUnitAsked;
  int quantityAsked;
  String state;
  int totalQuantity;
  String variety;
  String village;
  String buyerName;

  RecentBidDataFarmer(
      {required this.auctionID,
        required this.buyerID,
        required this.certificateURL,
        required this.cropName,
        required this.district,
        required this.farmerID,
        required this.minimumQuantity,
        required this.offerperUnit,
        required this.offerperUnitAsked,
        required this.quantityAsked,
        required this.state,
        required this.totalQuantity,
        required this.variety,
        required this.village,
        required this.buyerName
      });

  factory RecentBidDataFarmer.fromJson(Map<String, dynamic> json) => RecentBidDataFarmer(
    auctionID : json['auctionID'],
    buyerID : json['buyerID'],
    certificateURL : json['certificateURL'],
    cropName : json['cropName'],
    district : json['district'],
    farmerID : json['farmerID'],
    minimumQuantity : json['minimumQuantity'],
    offerperUnit : json['offerperUnit'],
    offerperUnitAsked : json['offerperUnitAsked'],
    quantityAsked : json['quantityAsked'],
    state : json['state'],
    totalQuantity : json['totalQuantity'],
    variety : json['variety'],
    village : json['village'],
    buyerName : json["buyerName"]??"");


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auctionID'] = auctionID;
    data['buyerID'] = buyerID;
    data['certificateURL'] = certificateURL;
    data['cropName'] = cropName;
    data['district'] = district;
    data['farmerID'] = farmerID;
    data['minimumQuantity'] = minimumQuantity;
    data['offerperUnit'] = offerperUnit;
    data['offerperUnitAsked'] = offerperUnitAsked;
    data['quantityAsked'] = quantityAsked;
    data['state'] = state;
    data['totalQuantity'] = totalQuantity;
    data['variety'] = variety;
    data['village'] = village;
    data["buyerName"] = buyerName;
    return data;
  }
}