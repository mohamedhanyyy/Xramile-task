import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xramile/modules/google_map/presentation/screens/google_map_screen.dart';
import 'package:xramile/shared/themes/app_theme.dart';

import 'modules/google_map/business_logic/my_location_cubit.dart';
import 'modules/notifications/business_logic/notifications_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// make responsive design

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? _) {
        /// creating [LAZY] multi providers at the same time, lazy object is created if necessary
        return MultiBlocProvider(
          providers: [
            BlocProvider<NotificationsCubit>(
                create: (context) => NotificationsCubit()),
            BlocProvider<MyLocationCubit>(
                create: (context) => MyLocationCubit()),
          ],

          /// root of widget tree
          child: MaterialApp(
            theme: AppThemes.whiteTheme,
            debugShowCheckedModeBanner: false,
            home: const GoogleMapScreen(),
          ),
        );
      },
    );
  }
}
