
import 'package:flutter/material.dart';
import 'package:myfirstapp/bloc/homeBloc.dart';
import 'package:myfirstapp/tools/hive.dart';
import 'package:myfirstapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/page/message.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc bloc;
  User user;
  List<User> uses;
  @override
  void initState(){
    super.initState();
    user = getHiveUser();

    
  }
  var long;
  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<HomeBloc>(context,listen: true);
    long = bloc.messages.length;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text(user.username),
          // leading: FutureBuilder(
          //   future: ,
          //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          //     return 
            leading: Container(
              margin: EdgeInsets.only(left: 10),
              width: 20,
              decoration: BoxDecoration(
                color:  Colors.blue,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundImage: bloc.url!=null?NetworkImage(bloc.url): AssetImage('assets/images/profil.jpg'),
              ),
            // );
            // }
          ),
          actions: <Widget>[
            Container(  
              decoration: BoxDecoration(
                color:  Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: (){}),
              ),
            ),
            SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                color:  Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                  Navigator.pushNamed(context, '/profil');
                }),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20)
              ),
              child: FlatButton(
                  child: Row(
                  children: [
                    SizedBox(width: 5),
                    Icon(Icons.search),
                    SizedBox(width: 10),
                    Text('Search'),
                  ],
                ),
                onPressed: (){
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ),
            Container(
              height:90,
              child: buidStory(),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: bloc.messages.length,
                  itemBuilder: (context, index){
                    print("last messages");
                    print(bloc.messages[index]);
                    if(bloc.map.length == 0){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else{
                      return buildMessage(bloc.messages[long-1-index].userGetter,bloc.messages[long-1-index].messageContent,bloc.messages[long-1-index].keySender,"",context);
                    }
                      
                  }
                )
            ),
          ],
        ),
    );
  }
  buidStory(){

    return ListView.builder(
      
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index){
        return index==0?Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              GestureDetector(
                onTap: ()async{
                  return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("Prendre une photo"),
                onTap: () async {
                  final PickedFile _image = await ImagePicker().getImage(source: ImageSource.camera);
                  if(_image!=null){
                    // bloc.addStory(File(_image.path), getHiveUid());
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text("Choisir une photo"),
                onTap: () async{
                  final PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);
                  if(image!=null){
                    // bloc.addStory(File(image.path), getHiveUid());
                  }
                },
              )
            ],
          ),
          );
                });
          },
                child: Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    shape: BoxShape.circle
                    ),
                    child: Center(child: Icon(Icons.add),),
                  ),
                ),
              ),
              SizedBox(height: 2,),
              Text(
                "Add your story",
                style: TextStyle(color: Colors.white,fontSize: 10),
              ),
            ],
          ),
        )
        :Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue,style: BorderStyle.solid),
                  shape: BoxShape.circle
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  shape: BoxShape.circle
                ),
                ),
              ),
              SizedBox(height: 2,),
              Text(
                "Mihary",
                style: TextStyle(color: Colors.white,fontSize: 10),
              ),
            ],
          ),
        );
      }
    );
  }

  buildMessage(sender,lastMessage,index,time,context){
    return ListTile(
      leading: Container(
        margin: EdgeInsets.only(left: 10),
        width: 50,
        decoration: BoxDecoration(
          color:  Colors.blue,
          image: DecorationImage(
            image: AssetImage('assets/images/profil.jpg'),
            fit: BoxFit.cover
          ),
          shape: BoxShape.circle,
        ),
        child: Container(),
      ),
      title: Text(
        sender,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        lastMessage,
        style: TextStyle(color: Colors.white),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(color: Colors.white),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle
            ),
          )
        ],
      ),
      onTap: () async{
                       Navigator.push(context, 
                         MaterialPageRoute(builder: (context)=> MessagePage(friendUid: index, friendName: sender)
                           )
                        );
                    
                   
                  },
    );
  }
}
