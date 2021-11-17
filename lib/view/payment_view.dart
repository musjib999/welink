import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopzler/core/services/payment_service.dart';
import 'package:shopzler/core/viewmodel/cart_viewmodel.dart';
import 'package:shopzler/view/cart_view.dart';
import 'package:shopzler/view/widgets/custom_button.dart';
import 'package:shopzler/view/widgets/custom_text.dart';

class PaymentView extends StatefulWidget {
  final String totalAmount;
  const PaymentView(this.totalAmount);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  PaymentService _paymentService = PaymentService();

  Color cardColor = Colors.white;
  Color deliveryColor = Colors.white;

  Color selectedColor = Colors.green;
  Color unselectedColor = Colors.white;

  @override
  void initState() {
    super.initState();
    print(widget.totalAmount);
    _paymentService.initPaystack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment method',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey.shade50,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                PaymentMethodListTile(
                  iconName: '4',
                  title: 'Card',
                  color: cardColor,
                  onTapFn: () {
                    setState(() {
                      cardColor = selectedColor;
                      deliveryColor = unselectedColor;
                    });
                  },
                ),
                PaymentMethodListTile(
                  iconName: '2',
                  title: 'on Delivery',
                  color: deliveryColor,
                  onTapFn: () {
                    setState(() {
                      cardColor = unselectedColor;
                      deliveryColor = selectedColor;
                    });
                  },
                ),
                CustomButton(
                  "Continue",
                  () {
                    if (cardColor == selectedColor) {
                      _paymentService
                          .makePayment(
                        amount: double.parse(widget.totalAmount).toInt() * 100,
                        context: context,
                      )
                          .then(
                        (value) {
                          print(value.status);
                          if (value.status == true) {
                            Get.snackbar(
                              'Payment Successfull',
                              'Your payment was successfull, thank you for choosing welink',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            Get.find<CartViewModel>().removeAllProducts();
                            Get.to(CartView());
                          } else if (value.status == false) {
                            Get.snackbar(
                              'Payment Cancelled',
                              'Your payment has been cancelled',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            Get.to(CartView());
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodListTile extends StatelessWidget {
  final String iconName;
  final String title;
  final VoidCallback onTapFn;
  final Color color;

  const PaymentMethodListTile({
    required this.iconName,
    required this.title,
    required this.onTapFn,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          // onTap: onTapFn,
          leading: Image.asset(
            'assets/images/icons/menu_icons/$iconName.png',
            height: 40.h,
            width: 40.h,
          ),
          title: CustomText(
            text: title,
            fontSize: 18,
          ),
          trailing: InkWell(
            onTap: onTapFn,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(25),
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
