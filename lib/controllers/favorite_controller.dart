import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_beedo_market/models/favorite_model.dart';

class FavoriteController{
  final GetStorage _storage = GetStorage();

  void saveCart(Map<int, FavoriteModel> favorite) {
    // Convert CartModule objects to JSON
    int userId = _storage.read('user_id');
    Map<String, dynamic> jsonMap = favorite.map((key, value) => MapEntry(key.toString(), value.toJson()));
    _storage.write("favorite$userId", jsonMap);
  }

  Map<int, FavoriteModel> loadCart() {
    int userId = _storage.read('user_id');
    Map<String, dynamic> jsonMap = _storage.read<Map<String, dynamic>>("favorite$userId") ?? {};
    // Convert JSON back to CartModule objects
    return jsonMap.map((key, value) => MapEntry(int.parse(key), FavoriteModel.fromJson(value)));
  }

  void addFavorite(FavoriteModel favorite){
    Map<int,FavoriteModel> theFavorite = loadCart();
      theFavorite.putIfAbsent(favorite.id, (){
        return FavoriteModel(
          id: favorite.id,
          name: favorite.name,
          desc: favorite.desc,
          img: favorite.img,
          price: favorite.price,
          quantity: favorite.quantity,
          isFavorit: favorite.isFavorit,
        );
      });
      saveCart(theFavorite);
      Get.snackbar('Success', 'add to favorite success');
  }

  void deleteFavorite(int id){
    Map<int,FavoriteModel> theFavorite = loadCart();
    if(theFavorite.containsKey(id)){
      theFavorite.remove(id);
      saveCart(theFavorite);
      Get.snackbar('Success', 'remove from favorite success');
    }else{
      Get.snackbar('Error', 'not found');
    }
  }

  bool isFavorite(int id){
    Map<int,FavoriteModel> theFavorite = loadCart();
    if(theFavorite.containsKey(id)){
      return true;
    }else{
      return false;
    }
  }

  List<FavoriteModel> get getItems{
    Map<int,FavoriteModel> theFavorite = loadCart();
    return theFavorite.entries.map((e){
      return e.value;
    }).toList();
  }

}