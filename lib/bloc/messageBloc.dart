import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:myfirstapp/models/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myfirstapp/tools/hive.dart';
class MessageBloc with ChangeNotifier {
  List<MessageModel> messages = [];
    Future<List<MessageModel>> getMessage(uid) async {
      var cpt = 0;
      FirebaseDatabase db = FirebaseDatabase();
      print("user uid");
      print(getHiveUid());
      await  db.reference().child('allMessages').child(getHiveUid()).child(uid).once().then((snapshot){
          if(snapshot.value != null){
            Map<dynamic, dynamic> map = snapshot.value;
            map.forEach((key, value) {
              if(cpt<map.length-1)
                messages.add(MessageModel.fromJson(value, uid));
              cpt++;
            }); 
          }
          else{
            MessageModel message = MessageModel(messageContent: "Salut "+getHiveUser().username,userSender: "");
            messages.add(message);
          }
        });
      return messages;
    }
    Future<List<MessageModel>> getNewMessage(uid) async{
      FirebaseDatabase db = FirebaseDatabase();
       db.reference().child('users/').child(getHiveUid()).child('allMessages').child(uid).orderByKey().limitToLast(1).onChildAdded.listen((event) {
         
                print("new value");
                print(event.snapshot.value);
                Map<dynamic, dynamic> map = event.snapshot.value;
                messages.add(MessageModel.fromJson(map, uid));
                notifyListeners();
       });
       return  messages;
    }
    Future<String> addNewMessage(uid, message, messageType) async {
     Completer completer = Completer<String>();
      FirebaseDatabase db = FirebaseDatabase();
      await db.reference().child('allMessages').child(getHiveUid()).child(uid).push().set({
        "userSender": getHiveUser().username,
        "messageContent": message,
        "messageType": messageType
      });

      await db.reference().child('allMessages').child(uid).child(getHiveUid()).push().set({
        "userSender": getHiveUser().username,
        "messageContent": message,
        "messageType": messageType
      });
      return completer.future;
    }

     addToLastMessage(friendUid, friendName,message, messageType) async {
      FirebaseDatabase db = FirebaseDatabase();
     await db.reference().child('lastMessages/').child(getHiveUid()).child(friendUid).remove();
     await db.reference().child('lastMessages/').child(friendUid).child(getHiveUid()).remove();
      print("add last message");
      await db.reference().child('lastMessages/').child(getHiveUid()).child(friendUid).set({
            "userGetter": friendName,
            "userSender": getHiveUser().username,
            "messageContent": message,
            "messageType": messageType
      });
      await db.reference().child('lastMessages/').child(friendUid).child(getHiveUid()).set({
          	"userGetter": getHiveUser().username,
            "userSender": getHiveUser().username,
            "messageContent": message,
            "messageType": messageType
      });
    }

}