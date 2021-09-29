class FoodModel {
  String id;
  String idShop;
  String nameType;
  String pathImage;
  String price;
  String detail;

  FoodModel(
      {this.id,
      this.idShop,
      this.nameType,
      this.pathImage,
      this.price,
      this.detail});

  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShop = json['idShop'];
    nameType = json['NameType'];
    pathImage = json['PathImage'];
    price = json['Price'];
    detail = json['Detail'];
  }

  String get transport => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShop'] = this.idShop;
    data['NameType'] = this.nameType;
    data['PathImage'] = this.pathImage;
    data['Price'] = this.price;
    data['Detail'] = this.detail;
    return data;
  }
}

