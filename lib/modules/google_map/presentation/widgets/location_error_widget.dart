import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/my_location_cubit.dart';

Widget locationErrorWidget({required BuildContext context}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'No location detected',
        style: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 12.sp, color: Colors.red),
      ),
      SizedBox(
        width: 10.w,
        height: 40.h,
      ),
      InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: InkWell(
                onTap: () async {
                  context
                      .read<MyLocationCubit>()
                      .accessDeniedLocation(context: context);
                },
                child: const Text('Click to grant location')),
            backgroundColor: Colors.red,
          ));
        },
        child: Text(
          'Try again',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              decoration: TextDecoration.underline),
        ),
      ),
    ],
  );
}
