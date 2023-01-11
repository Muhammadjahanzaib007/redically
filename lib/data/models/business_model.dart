class Business {
  String? name;
  String? buisnessType;
  String? description;
  int? categoryId;
  String? businessimgUrl;
  String? categories;
  int? id;
  String? modifiedBy;
  String? createdBy;
  String? createdAt;
  String? modifiedAt;
  bool? isActive;
  bool? isDeleted;

  Business(
      {this.name,
        this.buisnessType,
        this.description,
        this.categoryId,
        this.businessimgUrl,
        this.categories,
        this.id,
        this.modifiedBy,
        this.createdBy,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted});

  Business.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buisnessType = json['buisnessType'];
    description = json['description'];
    categoryId = json['categoryId'];
    businessimgUrl = json['businessimgUrl'];
    categories = json['categories'];
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
    data['name'] = this.name;
    data['buisnessType'] = this.buisnessType;
    data['description'] = this.description;
    data['categoryId'] = this.categoryId;
    data['businessimgUrl'] = this.businessimgUrl;
    data['categories'] = this.categories;
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