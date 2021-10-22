import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfirstapp/models/user.dart';
import 'package:myfirstapp/api/firebaseService.dart';
import 'package:myfirstapp/tools/hive.dart';

class LoginBloc with ChangeNotifier {
String status;

 signIn(User user) async{
   
    Completer completer = Completer<String>();
    FirebaseService service = FirebaseService.instance;
    FirebaseDatabase db = FirebaseDatabase();
    await service.signIn(user.email, user.password).then((value){
      print(value);
      if(value!="not ok"){
        db.reference().child('users/'+value.user.uid).once().then((DataSnapshot snapshot){
              print(snapshot.value);
              user = User.fromJSON(snapshot.value, value.user.uid);
              saveHiveUser(user);
              saveHiveUid(value.user.uid);
              completer.complete("ok");
              status = "ok";
        });
      }
      else{
        status = "not ok";
        notifyListeners();
        return;
      }
    });
    
  }

}