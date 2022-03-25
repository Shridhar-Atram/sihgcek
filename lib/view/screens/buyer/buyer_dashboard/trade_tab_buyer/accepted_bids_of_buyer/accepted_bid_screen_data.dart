class AcceptedBidBuyerData {
  String auctionID;
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

  AcceptedBidBuyerData(
      {required this.auctionID,
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

  factory AcceptedBidBuyerData.fromJson(Map<String, dynamic> json) => AcceptedBidBuyerData(
    auctionID : json['auctionID'],
    buyerID : json['buyerID'],
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auctionID'] = this.auctionID;
    data['buyerID'] = this.buyerID;
    data['certificateURL'] = this.certificateURL;
    data['cropName'] = this.cropName;
    data['district'] = this.district;
    data['farmerID'] = this.farmerID;
    data['farmerName'] = this.farmerName;
    data['minimumQuantity'] = this.minimumQuantity;
    data['offerperUnit'] = this.offerperUnit;
    data['offerperUnitAsked'] = this.offerperUnitAsked;
    data['quantityAsked'] = this.quantityAsked;
    data['state'] = this.state;
    data['totalQuantity'] = this.totalQuantity;
    data['transport'] = this.transport;
    data['variety'] = this.variety;
    data['village'] = this.village;
    return data;
  }
}