
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/bloc/profilBloc.dart';
import 'package:myfirstapp/tools/hive.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({ Key key }) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  ProfilBloc bloc;
  File avatar;
  @override 
  void initState(){
    super.initState();
    //bloc = Provider.of<ProfilBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                   width: 200,
                   height: 200,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.circle,
                     image: DecorationImage(
                       image: avatar==null?AssetImage('assets/images/profil.jpg'):Image.file(avatar,fit: BoxFit.cover).image,
                     )
                   ),
                ),
                SizedBox(height: 50,),
                TextButton(
                  onPressed: (){
                    _buildDialog();
                  }, 
                  child: Text("choisir une photo"),
                ),
                SizedBox(height: 2,),
                TextButton(
                  onPressed: (){
                    if(avatar!=null){
                      FirebaseStorage.instance.ref().child('pdp/'+getHiveUid()).putFile(avatar).then((taskSnapshot){
                      taskSnapshot.ref.getDownloadURL().then((value){
                              print(value);
                          });
                      });
                    }else{
                      showDialog(
                        context: context, 
                        builder: (context){
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Ajouter votre photo de profil")
                          );
                        }
                      );
                    }
                    
                  }, 
                  child: Text("Mettre à jour"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildDialog(){
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
                  if(_image!=null)
                  {
                    setState(() {
                      avatar = File(_image.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text("Choisir une photo"),
                onTap: () async{
                  final PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);
                  if(image!=null){
                    setState(() {
                      avatar = File(image.path);
                    });
                  }
                },
              )
            ],
          ),
        );
      }
    );
  }
}