import 'package:flutter/material.dart';
import 'package:myfirstapp/bloc/messageBloc.dart';
import 'package:myfirstapp/bloc/searchBloc.dart';
import 'package:myfirstapp/models/message_model.dart';
import 'package:myfirstapp/models/user.dart';
import 'package:myfirstapp/page/home.dart';
import 'package:myfirstapp/page/message.dart';
import 'package:myfirstapp/tools/hive.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _search = TextEditingController();
  List<User> data;
  SearchBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<SearchBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
       appBar: AppBar(
         backgroundColor: Colors.black,
         leading: IconButton(
           icon: Icon(Icons.arrow_back),
           onPressed: (){
             Navigator.of(context).pop();
           },
         ),
         title: TextField(
           controller: _search,
           decoration: InputDecoration(
             hintText: "Search",
             hintStyle: TextStyle(
               color: Colors.white
             ),
           ),
           style: TextStyle(
               color: Colors.white
             )
         ),
         actions: [
           IconButton(
             icon: Icon(Icons.search),
             onPressed: () async {
               data = await bloc.search(_search.text);
             },
           )
         ],
       ),
       body: Column(
         children: [
           SizedBox(height: 20),
           Expanded(
              child: data!=null?ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index){
                print(data[index]);
                return GestureDetector(
                  onTap: () async{
                    if(data[index].username != getHiveUser().username){
                       Navigator.push(context, 
                         MaterialPageRoute(builder: (context)=> MessagePage(friendName: data[index].username,friendUid: data[index].uid)
                           )
                        );
                    }
                   
                  },
                  child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                   Text(
                     data[index].username,
                     style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold
                     ),
                    ),
                    Text(
                     data[index].email,
                     style: TextStyle(
                       color: Colors.white
                     ),
                    )
                  ],
                  )
              ),
                );
              }
                ):Center(
              child: Text(
                "Aucun recherche",
                style: TextStyle(
             color: Colors.blue
                ),
               ),
                 ),
           ),
         ],
       ),
    );
  }
}