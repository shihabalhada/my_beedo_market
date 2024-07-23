import 'package:get/get.dart';
import 'package:my_beedo_market/data/repository/address_repo.dart';
import 'package:my_beedo_market/models/address_model.dart';

class AddressController extends GetxController {
  final AddressRepo addressRepo;

  AddressController({required this.addressRepo});

  var isLoading = false.obs;
  var addresses = <Address>[].obs;

  Future<void> addAddress(Address address) async {
    try {
      isLoading.value = true;
      Response response = await addressRepo.addAddress(address);
      if (response.statusCode == 200) {
        getAddresses(address.token!);
        Get.snackbar('Success', 'Address added successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to add address');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add address');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAddress(Address address) async {
    try {
      isLoading.value = true;
      Response response = await addressRepo.updateAddress(address);
      if (response.statusCode == 200) {
        getAddresses(address.token!);
        Get.snackbar('Success', 'Address updated successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to update address');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update address');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAddress(int id, String token) async {
    try {
      isLoading.value = true;
      Response response = await addressRepo.deleteAddress(id, token);
      if (response.statusCode == 200) {
        getAddresses(token);
        Get.snackbar('Success', 'Address deleted successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to delete address');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete address');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAddresses(String token) async {
    try {
      isLoading.value = true;
      Response response = await addressRepo.getAddresses(token);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'getting address success');
        var addressesJson = response.body as List;
        addresses.value = addressesJson.map((json) => Address.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to get addresses');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get addresses..........');
    } finally {
      isLoading.value = false;
    }
  }
}
