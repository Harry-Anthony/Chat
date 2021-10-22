import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/page/connexion.dart';
import 'package:myfirstapp/tools/hive.dart';
import 'package:myfirstapp/tools/routeSetting.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initHiveBox();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) =>
            routeSetting(settings)
      ,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFDFDB17),
              Color(0xFFDAD73A),
              Color(0xFFE6E226),
              Color(0xFFDCF861),
              Color(0xFFDFD990),  
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ConnexionPage()
            ),
          ],
        ),
      ), 
    );
  }
}
