import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:get/get.dart';
// import 'package:shopzler/core/viewmodel/profile_viewmodel.dart';

class PaymentService {
  String payStackKey = 'pk_test_d5d54214110ee9a975e1f27ce20f2d3c228adde9';

  final _plugin = PaystackPlugin();

  void initPaystack() {
    _plugin.initialize(publicKey: payStackKey);
  }

  Future<CheckoutResponse> makePayment(
      {required int amount,
      String? country,
      required BuildContext context}) async {
    Charge charge = Charge()
      ..amount = amount
      ..card = PaymentCard(
          number: '4084084084084081',
          cvc: '408',
          expiryMonth: 07,
          country: country,
          expiryYear: 22)
      ..reference = DateTime.now().microsecondsSinceEpoch.toString()
      ..email = 'musjib999@gmail.com';

    CheckoutResponse response = await _plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    return response;
  }
}
