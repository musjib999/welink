import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopzler/constants.dart';

import '../../core/viewmodel/auth_viewmodel.dart';
import '../../core/viewmodel/profile_viewmodel.dart';
import 'profile/cards_view.dart';
import 'profile/edit_profile_view.dart';
import 'profile/notifications_view.dart';
import 'profile/order_history_view.dart';
import 'widgets/custom_text.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileViewModel>(
        init: ProfileViewModel(),
        builder: (controller) => controller.loading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 58.h, right: 16.w, left: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 60.h,
                            backgroundImage:
                                AssetImage('assets/images/profile_pic.png'),
                            foregroundImage:
                                controller.currentUser!.pic != 'default'
                                    ? NetworkImage(controller.currentUser!.pic)
                                    : null,
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Column(
                            children: [
                              CustomText(
                                text: controller.currentUser!.name,
                                fontSize: 26,
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              CustomText(
                                text: controller.currentUser!.email,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      CustomListTile(
                        iconName: '1',
                        title: 'Edit Profile',
                        onTapFn: () {
                          Get.to(EditProfileView());
                        },
                      ),
                      CustomListTile(
                        iconName: '3',
                        title: 'Order History',
                        onTapFn: () {
                          Get.to(OrderHistoryView());
                        },
                      ),
                      CustomListTile(
                        iconName: '4',
                        title: 'Cards',
                        onTapFn: () {
                          Get.to(CardsView());
                        },
                      ),
                      CustomListTile(
                        iconName: '5',
                        title: 'Notifications',
                        onTapFn: () {
                          Get.to(NotificationsView());
                        },
                      ),
                      MyCustomListTile(
                        iconName: '7',
                        title: 'Contact Us',
                        onTapFn: () {
                          // Get.to(CardsView());
                        },
                      ),
                      CustomListTile(
                        iconName: '6',
                        title: 'Log Out',
                        onTapFn: () {
                          Get.find<AuthViewModel>().signOut();
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String iconName;
  final String title;
  final VoidCallback onTapFn;

  const CustomListTile({
    required this.iconName,
    required this.title,
    required this.onTapFn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTapFn,
          leading: Image.asset(
            'assets/images/icons/menu_icons/$iconName.png',
            height: 40.h,
            width: 40.h,
          ),
          title: CustomText(
            text: title,
            fontSize: 18,
          ),
          trailing: title == 'Log Out'
              ? null
              : Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class MyCustomListTile extends StatelessWidget {
  final String iconName;
  final String title;
  final VoidCallback onTapFn;

  const MyCustomListTile({
    required this.iconName,
    required this.title,
    required this.onTapFn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTapFn,
          leading: Container(
            padding: EdgeInsets.all(8),
            color: primaryColor.withOpacity(0.10),
            child: Image.asset(
              'assets/images/icons/menu_icons/$iconName.png',
              height: 20.h,
              width: 20.h,
            ),
          ),
          title: CustomText(
            text: title,
            fontSize: 18,
          ),
          trailing: title == 'Log Out'
              ? null
              : Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
