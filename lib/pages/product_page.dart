import 'package:flutter/material.dart';
import 'package:flutter_product_card/flutter_product_card.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/categories_controller.dart';
import 'package:my_beedo_market/controllers/product_controller.dart';
import 'package:my_beedo_market/models/product_model.dart';
import 'package:my_beedo_market/pages/category_page.dart';

import '../routes/route_helper.dart';

class ProductView extends StatefulWidget {
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ProductController productController = Get.find<ProductController>();
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    categoryController.fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // productController.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: const Color(0xFFE27A22),
        actions: [
          IconButton(
            tooltip: "Edit",
            onPressed: () {
              Get.toNamed(RouteHelper.getSetting());
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
              size: 40.0,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Search",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.search,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Get.find<PaymentController>().fetchPaymentTypes();
              //     Get.toNamed(RouteHelper.getPayment());
              //   },
              //   child: Text("Payment"),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed(RouteHelper.getAddress());
              //   },
              //   child: Text("Address"),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // GestureDetector(
              //   onTap: () async {
              //     Get.toNamed(RouteHelper.getCart());
              //   },
              //   child: Text("Cart"),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed(RouteHelper.getProfile());
              //   },
              //   child: Text("Profile"),
              // ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryPage(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() {
                    if (productController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (productController.products.isEmpty) {
                      return Center(child: Text('No products available'));
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                          ),
                          itemCount: productController.products.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Product product = productController.products[index];
                            return ProductCard(
                              imageUrl:
                                  "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQndSK7hvssofrM2uzv75NxVjrkAwH3RwyqWcBesUsmq1ipmkuljRr6x_SRbCKaBXvjTR9CKfAaEFtmUFw-69o52wgVMgk2hp8KDYr4FvKtQ8ZfKewgOW4gDQ&usqp=CAE",
                              categoryName: product.category.name,
                              productName: product.productName,
                              price: product.skus.first.price,
                              shortDescription: product.productDescription,
                              onTap: () {
                                productController
                                    .getProductById(product.productId);
                                Get.toNamed(
                                    RouteHelper.getProduct(product.productId));
                              },
                              rating: 4.2,
                              discountPercentage: 35.0,
                              isAvailable: true,
                              cardColor: Colors.white,
                              textColor: Colors.black,
                              borderRadius: 8.0,
                            );
                          });
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
