import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MaterialApp(
  home: MyApp()
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    //Declare Settings  of notification for Android and ios device
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification:onSelectNotification);
  }

  // action perform on select notification - open alert dialog
  Future onSelectNotification(String payload){
    debugPrint("payload : $payload");
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text('Notification'),
      content: Text(payload),
    ));
  }

  // action perform on select notification - naviagte to another page
//  Future onSelectNotification(String payload) async{
//    await Navigator.push(context, MaterialPageRoute(
//        builder: (context) => SecondPage(payload:payload)),);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notification'),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Text('Coding With Flash'),
              RaisedButton(
                  onPressed: showNotification,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    decoration: const BoxDecoration(
                    gradient: LinearGradient(
                    colors: <Color>[
                    Colors.lime,
                      Colors.cyan
                    ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                   child: const Text('Click For Push Notification',
                      style: TextStyle(fontSize: 20,)
                      ),
                      ),
                      ),
            ],
          )
      ));
  }

  void showNotification() async{

    //Set Details of notification  to display
    var android =new AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Example of Local Notification',
        'Notification Created By Code Flash',
        platform,
        payload: 'Hurray !!! Code Flash Example work.'
    );
  }
}
