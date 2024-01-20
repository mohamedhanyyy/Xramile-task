
/// notification model
class NotificationModel {
  String? title;
  String? body;
  double? lat;
  double? lng;

  NotificationModel(
      {required this.lng,
      required this.lat,
      required this.title,
      required this.body});
}
