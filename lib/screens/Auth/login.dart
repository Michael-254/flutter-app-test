import 'package:flutter/material.dart';
import 'package:dashboard/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

  read() async {
    EasyLoading.dismiss();
    final prefs = await SharedPreferences.getInstance();
    //await prefs.clear();
    final key = 'token';
    final value = prefs.get(key ) ?? '0';

    if(value != '0'){
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  initState(){
    read();
  }

  Authenticate authenticate = new Authenticate();
  String msgStatus = '';

  final TextEditingController controllerEmail = new TextEditingController();
  final TextEditingController controllerPassword = new TextEditingController();

  Future<void> _showDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Failed'),
            content: new Text('${msgStatus}'),
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

  _onPressed(){

    final form = _formKeyLogin.currentState;
    EasyLoading.show(status: 'loading...');

    if (!form!.validate()) {
      EasyLoading.dismiss();
      return;
    }
    setState(() {
      if(controllerEmail .text.trim().toLowerCase().isNotEmpty &&
          controllerPassword.text.trim().isNotEmpty ){
        authenticate.loginData(controllerEmail.text.trim().toLowerCase(),
            controllerPassword.text.trim()).whenComplete((){
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


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('Login',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: FlutterEasyLoading(
        child: SingleChildScrollView(
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
              Form(
                  key: _formKeyLogin,
                  child: Column(
                    children: [
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextFormField(
                          controller: controllerEmail,
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
                            left: 15.0, right: 15.0, top: 15, bottom: 10),
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
                      TextButton(
                        onPressed: () {
                          //TODO FORGOT PASSWORD SCREEN GOES HERE
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: _onPressed,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  'New User? Create Account',
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
