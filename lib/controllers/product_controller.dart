import 'package:get/get.dart';
import 'package:my_beedo_market/data/repository/product_repo.dart';
import 'package:my_beedo_market/models/product_model.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;
  var products = <Product>[].obs;
  var selectedProduct = Rxn<Product>();
  var productbycategory=<Product>[].obs;
  var isLoading = false.obs;

  ProductController({required this.productRepo});

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    isLoading(true);

    var response = await productRepo.getAllProducts();
    if (response.statusCode == 200) {
      var productList = List<Product>.from(response.body.map((p) => Product.fromJson(p)));
      products(productList);
    }
    isLoading(false);
  }

  void getProductById(int id) async {
    isLoading(true);
    var response = await productRepo.getProductById(id);
    if (response.statusCode == 200) {
      selectedProduct(Product.fromJson(response.body));
    }
    isLoading(false);
  }

  void getProductByCategoryId(int id) async{
    isLoading(true);
    var response = await productRepo.getProductsByCategoryId(id);
    if (response.statusCode == 200) {
      var productList = List<Product>.from(response.body.map((p) => Product.fromJson(p)));
      productbycategory(productList);
    }
    isLoading(false);
  }
}

