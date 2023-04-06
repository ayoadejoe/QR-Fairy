import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:refresher/homey.dart';

import 'post_model.dart';

Future<dynamic> makeHomeCall() async {
  final String caller = 'ayoade';
  print('caller:${caller}');

  try {
    final response = await http.post(
      Uri.parse(
          'http://www.qrcode-authentication.iq-joy.com/qrfairyconfig.php'),
      body: {
        'caller': caller,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      print(responseMap);
      homey_model homey = homey_model.fromJson(responseMap);
      return homey;
    } else {
      print('HTTP error: ${response.statusCode}');
      return response.statusCode;
    }
  } catch (e) {
    return e.toString();
  }
}

Future<dynamic> makeRestfulCall(var url) async {
  //registeredclient?clientName=joseph
  var response = await http.get(url);
  print('Waiting for response for url:${url}');
  if (response.statusCode == 200) {
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    print(responseMap);
    Post post = Post.fromJson(responseMap);
    return post;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return 'Request failed with status: ${response.statusCode}.';
  }
}

Future<dynamic> saveNewUserRestCall(
    String username, String password, String email, String urls) async {
  var url = Uri.parse('${urls}/registernew?username=${username}' +
      '&password=${password}' +
      '&email=${email}' +
      '&urls=${urls}'); //registernewuser
  var response = await http.get(url);
  print('Waiting for save response');
  if (response.statusCode == 200) {
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    print(responseMap);
    Post post = Post.fromJson(responseMap);
    return post;
  } else {
    return 'Request failed with status: ${response.statusCode}.';
  }
}

Future<dynamic> loginRestCall(
    String username, String password, String urls) async {
  var url = Uri.parse('${urls}/registernew?username=${username}' +
      '&password=${password}'); //registernewuser
  var response = await http.get(url);
  print('Waiting for save response');
  if (response.statusCode == 200) {
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    print(responseMap);
    Post post = Post.fromJson(responseMap);
    return post;
  } else {
    return 'Request failed with status: ${response.statusCode}.';
  }
}
