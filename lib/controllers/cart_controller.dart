import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../models/cart_model.dart';

class CartStorageService {
  final GetStorage _storage = GetStorage();

  void saveCart(Map<int, CartModule> cart) {
    // Convert CartModule objects to JSON
    int cartId = _storage.read('cart_id');
    Map<String, dynamic> jsonMap = cart.map((key, value) => MapEntry(key.toString(), value.toJson()));
    _storage.write("cart$cartId", jsonMap);
  }

  Map<int, CartModule> loadCart() {
    int cartId = _storage.read('cart_id');
    Map<String, dynamic> jsonMap = _storage.read<Map<String, dynamic>>("cart$cartId") ?? {};
    // Convert JSON back to CartModule objects
    return jsonMap.map((key, value) => MapEntry(int.parse(key), CartModule.fromJson(value)));
  }

  void addCart(CartModule cart,int quantity){
    Map<int,CartModule> theCart = loadCart();
    if(quantity>0){
      theCart.putIfAbsent(cart.id, (){
        return CartModule(id: cart.id, name: cart.name, desc: cart.desc, img: cart.img, price: cart.price, quantity: cart.quantity,);
      });
      saveCart(theCart);
      Get.snackbar('Success', 'add to cart success');
    }else{
      Get.snackbar('Error', 'cant add an empty product to the cart');
    }
  }


  List<CartModule> get getItems{
    Map<int,CartModule> theCart = loadCart();
    return theCart.entries.map((e){
       return e.value;
    }).toList();
  }

  int cartCount(){
    int count = 0;
    Map<int,CartModule> theCart = loadCart();
      theCart.forEach((key,value){
        count +=1;
      });
      return count;
  }

}