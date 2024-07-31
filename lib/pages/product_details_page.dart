import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/product_controller.dart';
import 'package:my_beedo_market/models/product_model.dart';

class ProductDetailView extends StatelessWidget {
  final int productId;
  final ProductController productController = Get.find();

  ProductDetailView({required this.productId});

  @override
  Widget build(BuildContext context) {
    productController.getProductById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (productController.selectedProduct.value == null) {
          return Center(child: Text('Product not found'));
        } else {
          Product product = productController.selectedProduct.value!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  product.productDescription,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                _buildPhotoGallery(product.photo),
                SizedBox(height: 16),
                Text(
                  'Category: ${product.category.name}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Subcategory: ${product.category.subCategory.name}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'SKUs:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text('Add to Cart...............'),
                ),
                ...product.skus.map((sku) => _buildSkuDetail(sku)).toList(),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildPhotoGallery(List<String> photos) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Image.network(photos[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }

  Widget _buildSkuDetail(SKU sku) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SKU Code: ${sku.code}', style: TextStyle(fontSize: 16)),
            Text('Price: ${sku.price}', style: TextStyle(fontSize: 16)),
            if (sku.discount != null)
              Text(
                'Discount: ${sku.discount!.value} - Discounted Price: ${sku.discount!.discountedPrice}',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            Text('Attributes:', style: TextStyle(fontSize: 16)),
            ...sku.attributes.map((attr) {
              return Text(
                '${attr.mainAttribute}: ${attr.value}${attr.color != null ? ' - Color: ${attr.color}' : ''}',
                style: TextStyle(fontSize: 16),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
