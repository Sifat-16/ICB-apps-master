import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icbapps/screens/homepage/homescreen.dart';
import 'package:icbapps/screens/loginorsignup/loginorsignup.dart';
import 'package:icbapps/splash_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  FirebaseAuth auth = FirebaseAuth.instance;
  final Color _primaryColor = HexColor('#DC54FE');
  final Color _accentColor = HexColor('#8A02AE');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

       primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      
      ),
      home: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              return const HomeScreen();
            }
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
          }
          return SplashScreen(title: "ICB",);
        }
      ),
    );
  }
}


