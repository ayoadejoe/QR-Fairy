
import 'package:flutter/material.dart';
import 'http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class MyAppState extends ChangeNotifier {
  late SharedPreferences _prefs;
  MyAppState() {
    _init();
  }

  var current = "https://www.iq-joy.com";
  //WordPair.random();

  void getNext(String url){
    current = url;
    notifyListeners();
  }

  var favorites = [];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  bool isLoading = false;
  var registerSuccess;

  Future<void> saveNewUser(String username, String password, String email, String urls, BuildContext context) async {
    print('entering new user');
    isLoading = true;
    try {
      registerSuccess = await saveNewUserRestCall(username, password, email, urls);
      isLoading = true;
      showToast(context, 'You are now registered. All qrcodes you generate would be saved', "REGISTERED");
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  _init() async {
    // assign the SharedPreferences instance using the await keyword
    _prefs = await SharedPreferences.getInstance();
  }


  bool _registered = false;
  var _username;
  final String _regKey = "regkey";
  final String _userKey = "userkey";

  getUserName() {
    return _username = _prefs.getString(_userKey) ?? '';
  }
  // a method to save the user name to the SharedPreferences
  void saveUserName(String value) {
    _username = value;
    // save the user name to the SharedPreferences
    _prefs.setString(_userKey, value);
    _prefs.setBool(_regKey, true);
    print('saved new user to settings');
    // notify the listeners
    notifyListeners();
  }

}