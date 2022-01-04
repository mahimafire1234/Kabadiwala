import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createWaterReminderNotification(
    NotificationWeekAndTime notificationSchedule) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'schedule_reminder',
      title: '',
      body: 'You order in on its way',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'Read',
        label: 'Read',
      )
    ],
  );

}

createUniqueId() {
}

class NotificationWeekAndTime {
}