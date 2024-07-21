import 'package:get/get.dart';
import 'package:my_beedo_market/data/repository/payment_repo.dart';
import 'package:my_beedo_market/models/payment_type_model.dart';

class PaymentController extends GetxController {
  final PaymentRepo paymentRepo;

  PaymentController({required this.paymentRepo});

  var isLoading = false.obs;
  var paymentTypes = <PaymentType>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPaymentTypes();
  }

  void fetchPaymentTypes() async {
    try {
      isLoading.value = true;
      Response response = await paymentRepo.getPaymentTypes();
      if (response.statusCode == 200) {
        var paymentTypesJson = response.body['payment_types'] as List;
        paymentTypes.value = paymentTypesJson.map((json) => PaymentType.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to fetch payment types');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch payment types');
    } finally {
      isLoading.value = false;
    }
  }
}
