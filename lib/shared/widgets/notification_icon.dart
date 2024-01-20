import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:xramile/services/navigation/navigation.dart';

import '../../modules/notifications/presentation/screens/notifications_screen.dart';
import '../resources/colors.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(
      width: 35.sp,
      height: 35.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
        border: Border.all(
          color: AppColors.greyColor,
        ),
        boxShadow: const [
          BoxShadow(color: AppColors.greyColor, blurRadius: 6),
        ],
      ),
      child:   Center(
          child: Lottie.asset('assets/lottie/notification.json')),
    ),
    onTap: (){
      AppNavigation.navigate(context: context, page: NotificationsScreen());
    },
    );
  }
}
