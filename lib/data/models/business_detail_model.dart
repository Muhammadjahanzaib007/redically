class BusinessDetail {
  String? message;
  String? status;
  bool? isSuccess;
  int? errorCode;
  Payload? payload;
  int? pageNumber;
  int? rowNumber;
  int? total;
  int? nextPage;

  BusinessDetail(
      {this.message,
      this.status,
      this.isSuccess,
      this.errorCode,
      this.payload,
      this.pageNumber,
      this.rowNumber,
      this.total,
      this.nextPage});

  BusinessDetail.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    isSuccess = json['isSuccess'];
    errorCode = json['errorCode'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
    pageNumber = json['pageNumber'];
    rowNumber = json['rowNumber'];
    total = json['total'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['isSuccess'] = this.isSuccess;
    data['errorCode'] = this.errorCode;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    data['pageNumber'] = this.pageNumber;
    data['rowNumber'] = this.rowNumber;
    data['total'] = this.total;
    data['nextPage'] = this.nextPage;
    return data;
  }
}

class Payload {
  String? name;
  String? buisnessType;
  String? description;
  String? businessimgUrl;
  List<String>? categories;
  List<Offer>? offer;
  bool? isDeleted;
  String? coverImgUrl;
  String? address;
  String? phoneNumber;

  Payload(
      {this.name,
      this.buisnessType,
      this.description,
      this.businessimgUrl,
      this.categories,
      this.offer,
      this.isDeleted,
      this.coverImgUrl,
      this.address,
      this.phoneNumber});

  Payload.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buisnessType = json['buisnessType'];
    description = json['description'];
    businessimgUrl = json['businessimgUrl'];
    categories = json['categories'];
    if (json['offer'] != null) {
      offer = <Offer>[];
      json['offer'].forEach((v) {
        offer!.add(Offer.fromJson(v));
      });
    }
    isDeleted = json['isDeleted'];
    coverImgUrl = json['coverImgUrl'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['buisnessType'] = this.buisnessType;
    data['description'] = this.description;
    data['businessimgUrl'] = this.businessimgUrl;
    data['categories'] = this.categories;
    if (this.offer != null) {
      data['offer'] = this.offer!.map((v) => v.toJson()).toList();
    }
    data['isDeleted'] = this.isDeleted;
    data['coverImgUrl'] = this.coverImgUrl;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

class Offer {
  int? fkUserId;
  String? user;
  String? item;
  int? businessId;
  String? qRcode;
  int? discount;
  String? offerStartDate;
  String? offerEndDate;
  bool? isExpired;
  String? offerName;
  String? offerImageUrl;
  String? offerDescription;
  int? offerPrice;
  int? id;
  String? modifiedBy;
  String? createdBy;
  String? createdAt;
  String? modifiedAt;
  bool? isActive;
  bool? isDeleted;

  Offer(
      {this.fkUserId,
      this.user,
      this.item,
      this.businessId,
      this.qRcode,
      this.discount,
      this.offerStartDate,
      this.offerEndDate,
      this.isExpired,
      this.offerName,
      this.offerImageUrl,
      this.offerDescription,
      this.offerPrice,
      this.id,
      this.modifiedBy,
      this.createdBy,
      this.createdAt,
      this.modifiedAt,
      this.isActive,
      this.isDeleted});

  Offer.fromJson(Map<String, dynamic> json) {
    fkUserId = json['fkUserId'];
    user = json['user'];
    item = json['item'];
    businessId = json['businessId'];
    qRcode = json['qRcode'];
    discount = json['discount'];
    offerStartDate = json['offerStartDate'];
    offerEndDate = json['offerEndDate'];
    isExpired = json['isExpired'];
    offerName = json['offerName'];
    offerImageUrl = json['offerImageUrl'];
    offerDescription = json['offerDescription'];
    offerPrice = json['offerPrice'];
    id = json['id'];
    modifiedBy = json['modifiedBy'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fkUserId'] = this.fkUserId;
    data['user'] = this.user;
    data['item'] = this.item;
    data['businessId'] = this.businessId;
    data['qRcode'] = this.qRcode;
    data['discount'] = this.discount;
    data['offerStartDate'] = this.offerStartDate;
    data['offerEndDate'] = this.offerEndDate;
    data['isExpired'] = this.isExpired;
    data['offerName'] = this.offerName;
    data['offerImageUrl'] = this.offerImageUrl;
    data['offerDescription'] = this.offerDescription;
    data['offerPrice'] = this.offerPrice;
    data['id'] = this.id;
    data['modifiedBy'] = this.modifiedBy;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedAt'] = this.modifiedAt;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}
