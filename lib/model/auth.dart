import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate {

  String serverUrl = "https://test.betterglobeforestry.co.ke/api";

  bool status = false;
  var  token = '';
  String serverMessage = '';
  String combinedMessage = '';

  registerUser(String name ,String email , String password,String confirmPassword, String deviceName) async{

    String url = "$serverUrl/register";
    serverMessage = '';

    final response = await  http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password' : password,
          'password_confirmation' : confirmPassword,
          'deviceName' : deviceName,
        })
    );

    status = response.body.contains('token');

    var data = await json.decode(response.body);

    if(status){
      print('data : ${data["token"]}');
      _save(data['token'],data['name'],data['email']);
    }else{
      data['error'].forEach((key, messages) {
        for (var message in messages) combinedMessage = combinedMessage + "$message\n";
      });
      getMessage(combinedMessage);
    }

  }

  loginData(String email , String password) async{

    String url = "$serverUrl/login";
    serverMessage = '';

    final response = await  http.post(Uri.parse(url),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'email': email,
          'password' : password
        } ) ;

    //print(response);
    status = response.body.contains('token');

    var data = json.decode(response.body);

    if(status){
      //print('data : ${data["token"]}');
      _save(data['token'],data['name'],data['email']);
    }else{
       getMessage(data['message']);
    }

  }

  logout() async{
    serverMessage = '';
    String url = "$serverUrl/logout";
    final prefs = await SharedPreferences.getInstance();
    final key = 'email';
    final email = prefs.get(key ) ?? '0';
    if(email != '0'){
        var response = await http.post(Uri.parse(url),
            headers: {
              'Accept': 'application/json',
            },
            body: {
              'email': email,
            });

        print(response.statusCode);
        if(response.statusCode == 204){
          status = response.statusCode == 204;
          SharedPreferences localStorage = await SharedPreferences.getInstance();
          localStorage.remove('email');
          localStorage.remove('name');
          localStorage.remove('token');
        }
    }

  }

  _save(String token, String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
    prefs.setString('name', name);
    prefs.setString('email', email);
  }

  Future<void> getMessage(data) async {
     return serverMessage = data;
  }

}