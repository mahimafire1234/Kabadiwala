import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> reminder(
    NotificationWeekAndTime notificationSchedule) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: 'reminder',
      body: 'You order in on its way',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'Read',
        label: 'Read',
      )
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.day,
      hour: notificationSchedule.hour,
      minute: notificationSchedule.minute,
      second: 0,
      millisecond: 0,
    ),
  );

}

class NotificationWeekAndTime {
  int day;
  int hour;
  int minute;

  NotificationWeekAndTime({required this.day, required this.hour, required this.minute});
}

createUniqueId() {
  Random random = Random();
  int randomNumber = random.nextInt(100);
  return randomNumber;
}
