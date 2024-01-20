import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors.dart';

class LocationIcon extends StatelessWidget {
  const LocationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: const Center(
          child: Icon(
        Icons.gps_fixed,
        color: Colors.green,
      )),
    );
  }
}
