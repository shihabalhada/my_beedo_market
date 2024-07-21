class Attribute {
  String mainAttribute;
  String value;
  String? color;

  Attribute({required this.mainAttribute, required this.value, this.color});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      mainAttribute: json['main_attribute'],
      value: json['value'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main_attribute': mainAttribute,
      'value': value,
      'color': color,
    };
  }
}

class Discount {
  String? value;
  double? discountedPrice;

  Discount({ this.value, this.discountedPrice});

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      value: json['value'],
      discountedPrice: json['discounted_price']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'discounted_price': discountedPrice,
    };
  }
}

class SKU {
  int id;
  double price;
  String code;
  Discount discount;
  List<Attribute> attributes;

  SKU({required this.id, required this.price, required this.code, required this.discount, required this.attributes});

  factory SKU.fromJson(Map<String, dynamic> json) {
    var attributesJson = json['attribute'] as List;
    List<Attribute> attributesList = attributesJson.map((i) => Attribute.fromJson(i)).toList();

    return SKU(
      id: json['id'],
      price: json['price'].toDouble(),
      code: json['code'],
      discount: Discount.fromJson(json['discount']),
      attributes: attributesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'code': code,
      'discount': discount.toJson(),
      'attribute': attributes.map((i) => i.toJson()).toList(),
    };
  }
}

class SubCategory {
  int id;
  String name;

  SubCategory({required this.id, required this.name});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Category {
  int id;
  String name;
  SubCategory subCategory;

  Category({required this.id, required this.name, required this.subCategory});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      subCategory: SubCategory.fromJson(json['sub_category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sub_category': subCategory.toJson(),
    };
  }
}

class Product {
  int productId;
  String productName;
  String productDescription;
  List<String> photo;
  Category category;
  List<SKU> skus;

  Product({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.photo,
    required this.category,
    required this.skus,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var photoJson = json['photo'] as List;
    List<String> photoList = photoJson.map((i) => i.toString()).toList();

    var skusJson = json['skus'] as List;
    List<SKU> skusList = skusJson.map((i) => SKU.fromJson(i)).toList();

    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      productDescription: json['product_description'],
      photo: photoList,
      category: Category.fromJson(json['category']),
      skus: skusList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_description': productDescription,
      'photo': photo,
      'category': category.toJson(),
      'skus': skus.map((i) => i.toJson()).toList(),
    };
  }
}
