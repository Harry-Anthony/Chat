

import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myfirstapp/models/user.dart';

class SearchBloc with ChangeNotifier {
  
  Future<List<User>> search(nom) async{
    FirebaseDatabase db = FirebaseDatabase();
    List<User> data;
    User user = User();
    await db.reference().child('users/').once().then((DataSnapshot snapshot){
      if(snapshot != null ){
        data = [];
        print(snapshot.value);
        Map<dynamic, dynamic> map = snapshot.value;
        map.forEach((key, value){
          print(value["username"]);
          print(value);
          if(value["username"] == nom){
            user =  User.fromJSON(value,key);
            data.add(user);
          }
        });
      }
    });
    notifyListeners();
    return data;
    
  }

}