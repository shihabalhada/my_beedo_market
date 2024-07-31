// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

class CartModule {
  int id;
  String name;
  String desc;
  String img;
  int price;
  int quantity;

  CartModule({
    required this.id,
    required this.name,
    required this.desc,
    required this.img,
    required this.price,
    required this.quantity,
  });

  factory CartModule.fromJson(Map<String, dynamic> json) {
    return CartModule(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      img: json['img'],
      price: json['price'],
      quantity: json['quantity'],
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
    };
  }
}