class CartModel {
  int id;
  String idShop;
  String nameShop;
  String idFood;
  String nameType;
  String price;
  String amount;
  String sum;
  String distance;
  String transport;

  CartModel(
      {this.id,
      this.idShop,
      this.nameShop,
      this.idFood,
      this.nameType,
      this.price,
      this.amount,
      this.sum,
      this.distance,
      this.transport});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShop = json['idShop'];
    nameShop = json['nameShop'];
    idFood = json['idFood'];
    nameType = json['nameType'];
    price = json['price'];
    amount = json['amount'];
    sum = json['sum'];
    distance = json['distance'];
    transport = json['transport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShop'] = this.idShop;
    data['nameShop'] = this.nameShop;
    data['idFood'] = this.idFood;
    data['nameType'] = this.nameType;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['sum'] = this.sum;
    data['distance'] = this.distance;
    data['transport'] = this.transport;
    return data;
  }
}

