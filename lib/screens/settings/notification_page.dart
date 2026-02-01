import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool general = true;
  bool events = true;
  bool reminders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, {
              'general': general,
              'events': events,
              'reminders': reminders,
            });
          },
        ),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('General notifications'),
            value: general,
            onChanged: (v) => setState(() => general = v),
          ),
          SwitchListTile(
            title: const Text('Event updates'),
            value: events,
            onChanged: (v) => setState(() => events = v),
          ),
          SwitchListTile(
            title: const Text('Reminders'),
            value: reminders,
            onChanged: (v) => setState(() => reminders = v),
          ),
        ],
      ),
    );
  }
}
