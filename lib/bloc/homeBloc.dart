import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myfirstapp/models/message_model.dart';
import 'package:myfirstapp/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myfirstapp/tools/hive.dart';
class HomeBloc with ChangeNotifier {
    String url;
  
    List<MessageModel> messages = [];
    List<String> uids = [];
    List<User> users = [];
    Map<dynamic, dynamic> map;
   Future<dynamic> getLastMessage()  async{
      await getUrlImage();
      FirebaseDatabase db = FirebaseDatabase();
      db.reference().child('lastMessages/').child(getHiveUid()).onValue.listen((event){
        messages = [];
          map = event.snapshot.value;
          if(map!=null){
            map.forEach((key, value) {
            messages.add(MessageModel.fromJson(value,key));
              print(key); 
              uids.add(key);
         });
          }
          
          notifyListeners();
      });

    }
    //  getAllLastUsers(List uis)async{
    //   FirebaseDatabase db = FirebaseDatabase();
    //   for(int i=0; i<uis.length;i++){
    //     db.reference().child('users/').child(uis[i]).onValue.listen((event) {
    //         map = event.snapshot.value;
    //         users.add(User.fromJSON(map, uis[i]));
    //     });
    //   }

    // }
    
  //   Future<String> addPdp(file,filename) async {
  //   String url;
  //   FirebaseStorage storage =FirebaseStorage.instance;

  //    storage.ref().child('pdp/'+filename).putData(file).then((taskSnapshot){
  //      taskSnapshot.ref.getDownloadURL().then((value){
  //        url = value;
  //      });
  //    });

  //    return url;
  // }
    getUrlImage() async {
      url = await FirebaseStorage.instance.ref().child('pdp/'+getHiveUid()).getDownloadURL();
      print(url);
    }


    // pour obtenir tous les storys
    getAllStory() async {
        FirebaseStorage storage =FirebaseStorage.instance;

        storage.ref().child('story').listAll().then((value){
            print("story ");
            value.items.forEach((element) {
              print(element);
            });
        });
    }

    // addStory(file, filename) async {

    //     FirebaseStorage storage =FirebaseStorage.instance;

    //     storage.ref().child('story/'+filename).putFile(file).then((taskSnapshot){
    //       taskSnapshot.ref.getDownloadURL().then((value){
    //         url = value;
    //       });
    //     });


    // }
}