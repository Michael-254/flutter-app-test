import 'package:flutter/material.dart';
import 'package:dashboard/model/auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  Authenticate authenticate = new Authenticate();
  String msgStatus = '';
  late String deviceName = '';

  final controllername = TextEditingController();
  final controlleremail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPasswordConfirmation = TextEditingController();

  @override
    void initState() {
      super.initState();
      getDeviceName();
    }

    Future<void> getDeviceName() async {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

      try {
        if (Platform.isAndroid) {
          var build = await deviceInfoPlugin.androidInfo;
          setState(() {
            deviceName = build.model;
          });
        } else if (Platform.isIOS) {
          var build = await deviceInfoPlugin.iosInfo;
          setState(() {
            String? deviceName = build.model;
          });
        }
      } on PlatformException {
        setState(() {
          deviceName = 'Failed to get platform version';
        });
      }
    }

  Future<void> _showDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Failed'),
            content: new Text(msgStatus),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            actions: <Widget>[
              ElevatedButton(
                child: new Text(
                  'Close',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _onPressed() {

    final form = _formKey.currentState;
    EasyLoading.show(status: 'loading...');

    if (!form!.validate()) {
      EasyLoading.dismiss();
      return;
    }

    setState(() {

      if (controllername.text.trim().toLowerCase().isNotEmpty &&
          controlleremail.text.trim().isNotEmpty &&
          controllerPassword.text.trim().isNotEmpty &&
          controllerPasswordConfirmation.text.trim().isNotEmpty) {
        authenticate
            .registerUser(
            controllername.text.trim(),
            controlleremail.text.trim().toLowerCase(),
            controllerPassword.text.trim(),
            controllerPasswordConfirmation.text.trim(),
            deviceName)
            .whenComplete(() {
          if(authenticate.status){
            Navigator.pushReplacementNamed(context, '/dashboard');
          }else{
            EasyLoading.dismiss();
            _showDialog();
            msgStatus = authenticate.serverMessage;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text('Register',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                        width: 200,
                        height: 150,
                        /*decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50.0)),*/
                        child: Image.asset('images/logo.png')),
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: controllername,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                        ),
                        labelText: 'Names',
                        labelStyle: TextStyle(color: Colors.blue),
                        hintText: 'Enter your names'),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                    controller: controlleremail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.blue),
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: controllerPassword,
                    obscureText: true,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Enter secure password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: controllerPasswordConfirmation,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    obscureText: true,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password Confirmation',
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Confirm your password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: _onPressed,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, '/login');
                  },
                  child: Text(
                    'Have account? Login',
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
