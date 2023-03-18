import 'package:dashboard/model/auth.dart';
import 'package:dashboard/screens/Auth/login.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override

  void initState() {
    super.initState();
    EasyLoading.dismiss();
  }

  Authenticate authenticate = new Authenticate();

  Future<void> _logoutUser() async{

      Navigator.of(context).pop();
      EasyLoading.show(status: 'loading...');
      await authenticate.logout();
      print(authenticate.status);
      if(authenticate.status){
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (context) =>
                new Login()),
                (route) => false);
      }

  }

  Future<void> _showDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Logout'),
            content: new Text('Are you sure of logout'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: new Text(
                  'Close',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Yes'),
                onPressed: _logoutUser,
              ),
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text('Home',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: (){},
                value: 'profile',
                child: Text('Profile'),
              ),
              PopupMenuItem(
              onTap: () {
                  Future.delayed(
                    const Duration(seconds: 0),
                      () => _showDialog(),
                  );
                },
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (value) {
              // Handle menu item selection
            },
          ),
        ],
      ),
      body: FlutterEasyLoading(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: const TextSpan(
                    text: "Hello ",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    children: [
                      TextSpan(
                        text: "BRUNO",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ", welcome back!",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/box/box3.png'), fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Business Name',
                              style: const TextStyle(color: Colors.white,fontSize: 20.0),
                            ),
                            Text(
                              'Max Wines and Spirit',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/pic/img1.png',
                              height: 110,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Orders",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 240.0,),
                        Text(
                          "View All",
                          style: TextStyle(color: kDarkBlue, height: 2),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kLightBlue,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Number of Orders',
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color(0xff8EA3B7),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '20',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff006ED3),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kLightBlue,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Orders Pending',
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color(0xff8EA3B7),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '5',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff006ED3),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kLightBlue,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Orders Delivered',
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color(0xff8EA3B7),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '15',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff006ED3),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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

