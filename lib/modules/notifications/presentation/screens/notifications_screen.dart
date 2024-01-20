import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xramile/modules/notifications/business_logic/notifications_cubit.dart';
import 'package:xramile/modules/notifications/business_logic/notifications_state.dart';
import 'package:xramile/services/firebase/notifications/firebase_notification.dart';
import 'package:xramile/shared/resources/colors.dart';
import 'package:xramile/shared/widgets/back_button.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationsCubit notificationsCubit;

  @override
  void initState() {
    super.initState();
    /// initializing notification cubit
    notificationsCubit = context.read<NotificationsCubit>();
    /// get all user notifications
    notificationsCubit.getNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 118.h),
        child: const CustomBackButton(),
      ),
      body: BlocBuilder<NotificationsCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationDone) {

            /// list view of all user notifications
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 50),

              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(color: AppColors.primaryColor)),
                      title: Text(
                          '${notificationsCubit.getNotifications[index].title}'),
                      subtitle: Text(
                          '${notificationsCubit.getNotifications[index].body}'),
                      leading: const Icon(Icons.notifications,
                          color: AppColors.primaryColor),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ));
              },
              shrinkWrap: true,
              itemCount: notificationsCubit.getNotifications.length,
              physics: const BouncingScrollPhysics(),
            );
          }
          return const SizedBox.shrink();
        },
      ),

      /// send notification with this button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 50),
              side: const BorderSide(color: AppColors.pinkColor)),
          child: const Text(
            "Send notification",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () async {
            FirebaseCustomNotification.sendPushMessage(
              title: 'Mohamed Hany',
              body: '${DateTime.now()}'.split(' ').first,
                lat: 30.0566,
                lng: 31.3301,
                context: context,
            );
          },
        ),
      ),
    );
  }
}
