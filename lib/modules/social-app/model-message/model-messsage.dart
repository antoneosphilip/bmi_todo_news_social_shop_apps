import 'dart:convert';

class message {
  String? to;
  Notification ?notification;
  Android? android;
  Data ?data;


  message.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    notification = Notification.fromJson(json['notification']);
    android =
     Android.fromJson(json['android']);
    data =Data.fromJson(json['data']);
  }

}

class Notification {
  String? body;
  bool ?contentAvailable;
  String? priority;
  String ?subtitle;
  String ?title;


  Notification.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    contentAvailable = json['content_available'];
    priority = json['priority'];
    subtitle = json['subtitle'];
    title = json['Title'];
  }

}

class Android {
  String ?priority;
  Notification? notification;


  Android.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    notification =  Notification.fromJson(json['notification']);
  }

}

class Data {
  String ?priority;
  String? sound;
  bool ?contentAvailable;
  String? bodyText;
  String ?organization;



  Data.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    sound = json['sound'];
    contentAvailable = json['content_available'];
    bodyText = json['bodyText'];
    organization = json['organization'];
  }


}