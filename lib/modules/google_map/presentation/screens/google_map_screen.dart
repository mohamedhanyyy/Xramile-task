import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xramile/services/firebase/notifications/firebase_notification.dart';

import '../../../../shared/widgets/custom_app_bar.dart';
import '../../business_logic/my_location_cubit.dart';
import '../../business_logic/my_location_state.dart';
import '../widgets/get_location_done.dart';
import '../widgets/loading_location_widget.dart';
import '../widgets/location_error_widget.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late MyLocationCubit myLocationCubit;

  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  /// user markers
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    myLocationCubit = context.read<MyLocationCubit>();
    myLocationCubit.getMyLocationInfo(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 118.h),
        child: const CustomAppBar(text: 'Map Screen'),
      ),
      body: BlocBuilder<MyLocationCubit, MyLocationState>(
        builder: (context, state) {
          if (state is GetLocationDone) {
            /// if user granted permission
            FirebaseCustomNotification.setUpFirebase(
                latLng: myLocationCubit.latLng);

            return LocationDoneWidget(
              location: '${state.mark?.country}, ${state.mark?.street}',
              mapController: mapController,
              markers: markers,
              myLocationCubit: myLocationCubit,
            );
            /// if user didn't grant permission
          } else if (state is GetLocationError) {
            return locationErrorWidget(context: context);
          } else {
            return loadingLocationWidget();
          }
        },
      ),
    );
  }
}
