import 'package:flutter/material.dart';
import 'package:myfirstapp/bloc/homeBloc.dart';
import 'package:myfirstapp/bloc/loginBloc.dart';
import 'package:myfirstapp/page/home.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/models/user.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User user = User();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BuildContext  ctx =context;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            },
            color: Color(0xFF6CEC4C),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.only(top: 52),
            child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/chatImage.png")
                    )
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 30,right: 30),
                    child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      hintText: "Your mail",
                      hintStyle: TextStyle(color: Color(0xFF6CEC4C),fontWeight: FontWeight.w300,fontSize: 20),
                      prefixIcon: Icon(Icons.person,color: Colors.white54,size: 30,)
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 30,right: 30),
                  child: TextField(
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent, width: 2.0,),
                      ),
                       enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Color(0xFF6CEC4C),fontWeight: FontWeight.w300,fontSize: 20),
                      prefixIcon: Icon(Icons.security_outlined,color: Colors.white54,size: 30,)
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Consumer<LoginBloc>(
                      builder: (context,provider,widget){
                        return Container(
                        width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: FlatButton(
                          onPressed: (){
                            if (_email.text.isEmpty) {
                              AlertDialog(
                                elevation: 2,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(""),
                                    FlatButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text("ok"),
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              );
                              return;
                            }
                            user.email = _email.text;
                            user.password = _password.text;
                            provider.signIn(user).then((value) async {
                              print(provider.status);
                              if(provider.status == "ok"){
                                HomeBloc hb = HomeBloc();
                                
                                await hb.getLastMessage();
                                // await hb.getUrlImage();
                                //await hb.getAllStory();
                                Navigator.push(ctx, 
                                  MaterialPageRoute(builder: (context) => 
                                    ChangeNotifierProvider<HomeBloc>(
                                      create: (context)=> hb,
                                      child: Home(),
                                    )
                                  )
                                );
                              }else{
                                showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text("Vérifier votre adresse email \n\n\t\t ou  votre mot de passe")
                                            );
                                          });
                              }
                            }).catchError((error){
                              
                            });
                            
                          }, 
                          child: Text("Se connecter",
                            style: TextStyle(
                              color: Color(0xFF6CEC4C),
                              fontSize: 20,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      );
                    }
                    )
                  ]
                ),
              ],
            ),
            ),
          ),
        ),
    );
  }
  
}