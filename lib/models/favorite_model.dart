class FavoriteModel {

  int id;
  String name;
  String desc;
  String img;
  int price;
  int quantity;
  bool isFavorit;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.img,
    required this.price,
    required this.quantity,
    required this.isFavorit,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      img: json['img'],
      price: json['price'],
      quantity: json['quantity'],
      isFavorit: json['isFavorit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'img': img,
      'price': price,
      'quantity': quantity,
      'isFavorit': isFavorit,
    };
  }
}
