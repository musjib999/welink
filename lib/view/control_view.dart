import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopzler/constants.dart';
import 'package:shopzler/view/spalsh_screen.dart';

import '../core/viewmodel/auth_viewmodel.dart';
import '../core/viewmodel/control_viewmodel.dart';
import '../core/network_viewmodel.dart';
import 'auth/login_view.dart';
import 'widgets/custom_text.dart';

class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Get.find<AuthViewModel>().user == null
            ? LoginView()
            : Get.find<NetworkViewModel>().connectionStatus.value == 1 ||
                    Get.find<NetworkViewModel>().connectionStatus.value == 2
                ? GetBuilder<ControlViewModel>(
                    init: ControlViewModel(),
                    builder: (controller) => Scaffold(
                      body: controller.currentScreen,
                      bottomNavigationBar: CustomBottomNavigationBar(),
                    ),
                  )
                : SplashScreen();
      },
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84.h,
      child: GetBuilder<ControlViewModel>(
        builder: (controller) => BottomNavigationBar(
          showSelectedLabels: true,
          elevation: 0,
          selectedLabelStyle: TextStyle(fontSize: 12),
          selectedItemColor: primaryColor,
          backgroundColor: Colors.grey.shade100,
          currentIndex: controller.navigatorIndex,
          onTap: (index) {
            controller.changeCurrentScreen(index);
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home_outlined,
                size: 28.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Cart',
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 28.h,
              ),
              // activeIcon: CustomText(
              //   text: 'Cart',
              //   fontSize: 14,
              //   alignment: Alignment.center,
              // ),
            ),
            BottomNavigationBarItem(
              label: 'User',
              icon: Icon(
                Icons.person_outline_outlined,
                size: 28.h,
              ),
              // activeIcon: CustomText(
              //   text: 'Account',
              //   fontSize: 14,
              //   alignment: Alignment.center,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 30.h,
            ),
            CustomText(
              text: 'Please check your internet connection..',
              fontSize: 14,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
