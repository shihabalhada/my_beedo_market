import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_beedo_market/data/repository/favorite_repo.dart';
import 'package:my_beedo_market/models/favorite_model.dart';

class FavoriteController extends GetxController {
  final FavoriteRepo favoriteRepo;
  final GetStorage storage = GetStorage();
  var favoriteMethod = <FavoriteModel>[].obs;
  bool isLoading = false;

  FavoriteController({required this.favoriteRepo});

  Future<void> addToFavorite(FavoriteModel favoriteModel) async {
    try {
      isLoading = true;
      update();

      Response response = await favoriteRepo.addToFavorite(favoriteModel.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Product added to favorites successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to add to favorites');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add to favorites');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getFavorite(FavoriteModel favoriteModel) async{
    try {
      isLoading=true;
      Response response = await favoriteRepo.getFavorite(favoriteModel.toJson());

      if (response.statusCode == 200) {
        var favoriteList = response.body as List;
        favoriteMethod.value = favoriteList.map((json) => FavoriteModel.fromJson(json)).toList();

      } else {
        Get.snackbar('Error', 'Failed to fetch Favorite');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch Favorite');
    } finally {
      isLoading=false;
    }
  }


  Future<void> deleteFromFavorite(FavoriteModel favoriteModel) async {
    try {
      isLoading = true;
      update();

      Response response = await favoriteRepo.deleteFromFavorite(favoriteModel.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Product removed from favorites successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to remove from favorites');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove from favorites');
    } finally {
      isLoading = false;
      update();
    }
  }
}
