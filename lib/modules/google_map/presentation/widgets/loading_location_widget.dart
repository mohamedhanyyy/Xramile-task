import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/resources/colors.dart';

Widget loadingLocationWidget() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Center(
      child: Text(
        'Detecting location...',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
          color: AppColors.greyTextColor,
        ),
      ),
    ),
  );
}
