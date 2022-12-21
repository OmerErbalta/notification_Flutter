import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class notificationApp extends StatefulWidget {
  const notificationApp({super.key});

  @override
  State<notificationApp> createState() => _notificationAppState();
}

class _notificationAppState extends State<notificationApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () { await NotificationApi.showSchedulNotification(
            id: i,
            title: oAnkiMusteri.isim + " " + oAnkiMusteri.soyisim,
            body: bildirimListesi[i].mesaj,
            scheduledDate: DateTime.now().add(Duration(seconds: 4)));},
        child: Text("click"),
      ),
    );
  }
}
