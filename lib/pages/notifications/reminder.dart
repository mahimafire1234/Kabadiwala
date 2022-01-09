import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> reminder(
    NotificationWeekAndTime notificationSchedule,
    String title,
    String body
    ) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'Read',
        label: 'Read',
      )
    ],
    schedule: NotificationCalendar(
      year: notificationSchedule.year,
      month: notificationSchedule.month,
      day: notificationSchedule.day,
      hour: notificationSchedule.hour,
      minute: notificationSchedule.minute,
      second: 0,
      millisecond: 0,
    ),
  );

}



class NotificationWeekAndTime {
  int year;
  int month;
  int day;
  int hour;
  int minute;

  NotificationWeekAndTime({required this.year, required this.month, required this.day, required this.hour, required this.minute});
}

createUniqueId() {
  Random random = Random();
  int randomNumber = random.nextInt(100);
  return randomNumber;
}