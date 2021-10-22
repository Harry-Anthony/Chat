import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/tools/hive.dart';
import 'package:myfirstapp/models/message_model.dart';
class MessagePage extends StatefulWidget {
  String friendName;
  String friendUid;
  MessagePage({Key key,this.friendName,this.friendUid}) : super(key: key);
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  StreamController<String> controllerStream = StreamController<String>();
  ScrollController _scrollController = new ScrollController();
  List messages=[];
  Completer<String> completer = Completer();
  TextEditingController _message = TextEditingController();
  var cpt=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
        return  Scaffold(
        backgroundColor: Colors.black,
         appBar: AppBar(
           backgroundColor: Colors.black,
           leading:  Container(
             width: 30,
             height: 30,
              child: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){ 
                Navigator.of(context).pop();})
            ),
           title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle
                  ),
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                      widget.friendName,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "active now",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white24,fontWeight: FontWeight.w400,fontSize: 15),
                    )
                ]
              ),
            ]
           ),
           actions: [
              IconButton(icon: Icon(Icons.call,color: Colors.blue,), onPressed: (){}),
              IconButton(icon: Icon(Icons.video_call,color: Colors.blue,), onPressed: (){}),
              IconButton(icon: Icon(Icons.info,color: Colors.blue,), onPressed: (){}),
           ],
         ),
         body: Column(
           children: [
             Expanded(
               child: buildMessageDetail(),
              ),
             Container(
               height: 70,
               alignment: Alignment.bottomLeft,
               child: Row(
                 children: <Widget>[
                   IconButton(icon: Icon(Icons.photo_camera), color: Colors.blue,onPressed: (){}),
                   IconButton(icon: Icon(Icons.photo_album),color: Colors.blue, onPressed: (){}),
                   IconButton(icon: Icon(Icons.record_voice_over_sharp), color: Colors.blue,onPressed: (){}),
                   Expanded(
                      child: TextField(
                        controller: _message,
                        style: TextStyle(color: Colors.white),
                       decoration: InputDecoration(
                         fillColor: Colors.white,
                         hintText: "Aa",
                         hintStyle: TextStyle(color: Colors.white10),
                         suffixIcon: IconButton(
                           icon: Icon(Icons.send), color: Colors.blue,
                           onPressed: () async {
                             if(_message.text.isNotEmpty){
                                sendMessage(_message.text, "text");
                             _message.clear();
                             }
                             
                           }
                        ),
                       )
                     ),
                   ),
                  IconButton(icon: Icon(Icons.favorite), color: Colors.blue,onPressed: (){}),
                 ],
               ),
             )
           ],
         )
      );
  }
  buildMessageDetail()  {
            return StreamBuilder(
              stream: controllerStream.stream,
              builder: (context,snapshot){
               
                if(snapshot.hasData){
                  print(snapshot.data);
                  if(snapshot.data == "okok"){
                    Timer(
                      Duration(seconds: 0),
                      (){
                        if(messages.length!=0)
                        return _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      }
                    );
                    return ListView.builder(
              itemCount: messages.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                
                return messages[index].userSender != getHiveUser().username?
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white 
                          ),
                      ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey
                        ),
                        constraints: BoxConstraints(
                          maxWidth: 150
                        ),
                      )
                    ],
                  ),
                ):
                Padding(
                  padding: EdgeInsets.all(5),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                      child: Text(
                       messages[index].messageContent,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white 
                        ),
                      ),
                      constraints: BoxConstraints(
                          maxWidth: 150
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue
                      ),
                    ),
                    SizedBox(width: 10)
                  ],
              ),
                );  
                    }
                  );
                  }
                  else {
                    return Container();
                  }
                  
                }
                else{
                    FirebaseDatabase.instance.reference().child('allMessages').child(getHiveUid()).child(widget.friendUid).once().then((snapshot){
                  if(snapshot.value != null){
                      Map<dynamic, dynamic> map = snapshot.value;
                      map.forEach((key, value) {
                        if(cpt<map.length-1)
                          messages.add(MessageModel.fromJson(value, widget.friendUid));
                        cpt++;
                      }); 
                      
                      
                    }
                    else{
                      completer.complete("sansMessage");
                      controllerStream.sink.add("sansMessage");
                    }
                    FirebaseDatabase.instance.reference().child('allMessages').child(getHiveUid()).child(widget.friendUid).orderByKey().limitToLast(1).onChildAdded.listen((event) {
                      
                          print("new value");
                          print(event.snapshot.value);
                          if(event.snapshot.value!=null){
                            Map<dynamic, dynamic> map = event.snapshot.value;
                            messages.add(MessageModel.fromJson(map, widget.friendUid));
                           
                            	
                               if(this.mounted){
                                setState(() {
                                
                              });
                              controllerStream.sink.add("okok");
                            }
                          }
                          else{
                            
                          }
                          
                      });
                  });
          
                  return Center(child: CircularProgressIndicator());
                }
                
              }
              
      );
    }
  sendMessage(message, messageType) async {
    print("addToLast");
     await FirebaseDatabase.instance.reference().child('allMessages').child(getHiveUid()).child(widget.friendUid).push().set({
        "userSender": getHiveUser().username,
        "messageContent": message,
        "messageType": messageType,
      });

      await FirebaseDatabase.instance.reference().child('allMessages').child(widget.friendUid).child(getHiveUid()).push().set({
        "userSender": getHiveUser().username,
        "messageContent": message,
        "messageType": messageType,
      });

    await FirebaseDatabase.instance.reference().child('lastMessages/').child(getHiveUid()).child(widget.friendUid).remove();
     await FirebaseDatabase.instance.reference().child('lastMessages/').child(widget.friendUid).child(getHiveUid()).remove();
      print("add last message");
      await FirebaseDatabase.instance.reference().child('lastMessages/').child(getHiveUid()).child(widget.friendUid).set({
            "userGetter": widget.friendName,
            "userSender": getHiveUser().username,
            "messageContent": message,
            "messageType": messageType,
      });
      await FirebaseDatabase.instance.reference().child('lastMessages/').child(widget.friendUid).child(getHiveUid()).set({
          	"userGetter": getHiveUser().username,
            "userSender": getHiveUser().username,
            "messageContent": message,
            "messageType": messageType,
      });
  }
}