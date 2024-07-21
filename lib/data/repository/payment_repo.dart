import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/utils/app_constants.dart';
import 'package:my_beedo_market/models/payment_type_model.dart';

class PaymentRepo extends GetxService {
  final ApiClient apiClient;

  PaymentRepo({required this.apiClient});

  Future<Response> getPaymentTypes() async {
    String token = GetStorage().read('token') ?? '';
    return await apiClient.getData(AppConstants.PAYMENT_METHODS_URI+"/?token=$token");
  }
}
