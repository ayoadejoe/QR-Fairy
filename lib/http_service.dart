import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';


Future<dynamic> makeRestfulCall(var url) async {
   //registeredclient?clientName=joseph
  var response = await http.get(url);
  print('Waiting for response for url:${url}');
  if(response.statusCode == 200 ){
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    print(responseMap);
    Post post = Post.fromJson(responseMap);
    return post;
  }else{
    print('Request failed with status: ${response.statusCode}.');
    return 'Request failed with status: ${response.statusCode}.';
  }
}

Future<dynamic> saveNewUserRestCall(String username, String password, String email, String urls) async {
  var url = Uri.parse('http://54.175.240.234/registernew?username=${username}'+'&password=${password}'
      +'&email=${email}'+'&urls=${urls}'); //registernewuser
  var response = await http.get(url);
  print('Waiting for save response');
  if(response.statusCode == 200 ){
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    print(responseMap);
    Post post = Post.fromJson(responseMap);
    return post;
  }else{
    return 'Request failed with status: ${response.statusCode}.';
  }
}