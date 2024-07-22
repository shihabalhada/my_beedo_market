class FavoriteModel {
  String token;
  int productId;

  FavoriteModel({required this.token, required this.productId});

  factory FavoriteModel.fromJson(Map<String, dynamic> json){
    return FavoriteModel(
        token: json['token'],
        productId: json['product_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'product_id': productId,
    };
  }
}
