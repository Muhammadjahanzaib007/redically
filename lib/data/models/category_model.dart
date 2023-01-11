class Category {
  int? id;
  String? name;
  String? imageUrl;
  String? createdAt;

  Category({this.id, this.name, this.imageUrl, this.createdAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['createdAt'] = this.createdAt;
    return data;
  }
}