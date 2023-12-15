// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

void saveSession(String apiToken, String email, Map<String, dynamic> info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> infoUser = [];
    info.forEach(
      (key, value) {
        infoUser.add(value.toString());
      },
    );

    prefs.setString('apiToken', apiToken);
    prefs.setString('email', email);
    prefs.setStringList('info', infoUser);
  }

  Map<String, dynamic> session = {};
  Future<Map<String, dynamic>> loadSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    session = {
      'apiToken': prefs.getString('apiToken'),
      'email': prefs.getString('email'),
      'info': prefs.getStringList('info'),
    };
    return session;
  }