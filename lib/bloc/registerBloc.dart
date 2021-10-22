import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfirstapp/models/user.dart';
import 'package:myfirstapp/api/firebaseService.dart';

class RegisterBloc with ChangeNotifier {
    
    Future<String> register(User user) async{
      Completer<String> completer = Completer<String>();
      FirebaseDatabase db = FirebaseDatabase();
      FirebaseService.instance.signUp(user.email, user.password).then((value){
        if(value != null){
          db.reference().child('users/').child(value.user.uid).set({
            "username": user.username,
            "email": user.email,
            "password": user.password
          }).then((_){
              FirebaseService.instance.signIn(user.email, user.password).then((value) {
                if(value != null){
                  completer.complete("ok");
                }
              });
          });
        }
      });
      return completer.future;
    }

}