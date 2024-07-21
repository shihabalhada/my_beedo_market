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
  List<SubCategory> subCategories;

  Category({required this.id, required this.name, required this.subCategories});

  factory Category.fromJson(Map<String, dynamic> json) {
    var subCategoriesJson = json['sub_categories'] as List;
    List<SubCategory> subCategoriesList =
    subCategoriesJson.map((i) => SubCategory.fromJson(i)).toList();

    return Category(
      id: json['id'],
      name: json['name'],
      subCategories: subCategoriesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sub_categories': subCategories.map((i) => i.toJson()).toList(),
    };
  }
}
