class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  Token? token;
  String? role;
  String? photo;
  bool? isApproved;
  int? step;
  String? brandId;
  String? fcmToken;
  bool? isMobileVerified;
  bool? isEmailVerified;
  String? lat;
  String? lng;
  String? calenderType;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.address,
      this.token,
      this.role,
      this.photo,
      this.isApproved,
      this.step,
      this.brandId,
      this.fcmToken,
      this.isMobileVerified,
      this.isEmailVerified,
      this.lat,
      this.lng,
      this.calenderType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
    role = json['role'];
    photo = json['photo'];
    isApproved = json['isApproved'];
    step = json['step'];
    brandId = json['brandId'];
    fcmToken = json['fcmToken'];
    isMobileVerified = json['isMobileVerified'];
    isEmailVerified = json['isEmailVerified'];
    lat = json['lat'];
    lng = json['lng'];
    calenderType = json['calenderType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    data['role'] = this.role;
    data['photo'] = this.photo;
    data['isApproved'] = this.isApproved;
    data['step'] = this.step;
    data['brandId'] = this.brandId;
    data['fcmToken'] = this.fcmToken;
    data['isMobileVerified'] = this.isMobileVerified;
    data['isEmailVerified'] = this.isEmailVerified;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['calenderType'] = this.calenderType;
    return data;
  }
}

class Token {
  String? tokenString;
  String? refreshToken;

  Token({this.tokenString, this.refreshToken});

  Token.fromJson(Map<String, dynamic> json) {
    tokenString = json['tokenString'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenString'] = this.tokenString;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
