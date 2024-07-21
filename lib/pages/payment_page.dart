import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/payment_controller.dart';
import 'package:my_beedo_market/data/repository/payment_repo.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/utils/app_constants.dart';

class PaymentPage extends StatelessWidget {
  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    paymentController.fetchPaymentTypes();
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Types'),
      ),
      body: Obx(() {
        if (paymentController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: paymentController.paymentTypes.length,
          itemBuilder: (context, index) {
            var paymentType = paymentController.paymentTypes[index];
            return ListTile(
              title: Text(paymentType.name),
            );
          },
        );
      }),
    );
  }
}
