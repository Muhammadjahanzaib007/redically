class WorkHistory {
  String? fkUserId;
  String? companyName;
  String? address;
  String? role;
  String? startDate;
  String? endDate;
  int? id;
  String? modifiedBy;
  String? createdBy;
  String? createdAt;
  String? modifiedAt;
  bool? isActive;
  bool? isDeleted;

  WorkHistory(
      {this.fkUserId,
      this.companyName,
      this.address,
      this.role,
      this.startDate,
      this.endDate,
      this.id,
      this.modifiedBy,
      this.createdBy,
      this.createdAt,
      this.modifiedAt,
      this.isActive,
      this.isDeleted});

  WorkHistory.fromJson(Map<String, dynamic> json) {
    fkUserId = json['fkUserId'];
    companyName = json['companyName'];
    address = json['address'];
    role = json['role'];
    startDate = json['startDate'];
    endDate = json['endDate'];
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
    data['companyName'] = this.companyName;
    data['address'] = this.address;
    data['role'] = this.role;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
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
