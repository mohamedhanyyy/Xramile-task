import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/notifications_model.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationState> {
  NotificationsCubit() : super(NotificationInitial());
  /// the list of all user notification he did
  List<NotificationModel> notifications = [];

  /// add notification function with firebase
  void addNotification({required NotificationModel notificationModel}) {
    notifications.add(notificationModel);
    emit(NotificationDone());
  }
  List<NotificationModel> get getNotifications =>notifications;

}
