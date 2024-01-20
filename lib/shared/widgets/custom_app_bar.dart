import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xramile/shared/widgets/notification_icon.dart';

import '../resources/colors.dart';
import 'location_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 50.h),
      height: 118.h,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.sp),
            bottomRight: Radius.circular(12.sp),
          ),
          boxShadow: [
            BoxShadow(
                color: AppColors.greyColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3)),
          ]),
      child: Row(
        children: [
          const LocationIcon(),
          SizedBox(width: 10.w),

          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const NotificationIcon(),

        ],
      ),
    );
  }
}
