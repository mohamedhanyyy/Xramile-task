import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../shared/resources/colors.dart';
import '../../business_logic/my_location_cubit.dart';

class LocationDoneWidget extends StatefulWidget {
  late MyLocationCubit myLocationCubit;
  late final String location;
  late Set<Marker> markers;
  late Completer<GoogleMapController> mapController;

  LocationDoneWidget(
      {super.key,
      required this.mapController,
      required this.location,
      required this.markers,
      required this.myLocationCubit});

  @override
  State<LocationDoneWidget> createState() => _LocationDoneWidgetState();
}

class _LocationDoneWidgetState extends State<LocationDoneWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 570.h,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
            child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                markers: widget.markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      widget.myLocationCubit.latLng?.latitude ?? 24.774265,
                      widget.myLocationCubit.latLng?.longitude ?? 46.738586),
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) async {
                  widget.mapController.complete(controller);
                  if (widget.myLocationCubit.latLng?.latitude != null &&
                      widget.myLocationCubit.latLng?.longitude != 0.0) {
                    widget.markers.add(Marker(
                      markerId: const MarkerId('myLocation'),
                      position: LatLng(
                        widget.myLocationCubit.latLng!.latitude,
                        widget.myLocationCubit.latLng!.longitude,
                      ),
                    ));
                    setState(() {});
                  }
                },
                onTap: (latLng) async {
                  widget.markers.add(Marker(
                      markerId: const MarkerId('myLocation'),
                      position: latLng));
                  setState(() {});
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 40.w,
                width: 40.w,
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.greenColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: const Center(child: Icon(Icons.add_location_outlined)),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                height: 40.w,
                child: Center(
                  child: Text(
                    'Your current location',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.greyTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            widget.location,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: AppColors.greyTextColor,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
