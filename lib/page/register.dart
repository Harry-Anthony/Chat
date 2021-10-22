import 'package:flutter/material.dart';
import 'package:myfirstapp/bloc/registerBloc.dart';
import 'package:myfirstapp/models/user.dart';
import 'package:myfirstapp/tools/hive.dart';
import 'package:provider/provider.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  User user = User();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  RegisterBloc bloc;
  bool _obscuredText = true;
  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<RegisterBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: "Votre adresse mail",
                  )
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                  controller: _username,
                  decoration: InputDecoration(
                    hintText: "Votre nom",
                  )
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                  controller: _password,
                  obscureText: _obscuredText,
                  decoration: InputDecoration(
                    hintText: "Votre mot de passe",
                    suffixIcon: _obscuredText?IconButton(
                      icon: Icon(Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          _obscuredText = false;
                        });
                      },
                    ):IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: (){
                        setState(() {
                          _obscuredText = true;
                        });
                      },
                    )
                  )
                ),
              ),
              SizedBox(height: 20),
              FlatButton(
                color: Color(0xFF6CEC4C),
                onPressed: (){
                  print(_email.text);
                  
                  user.email = _email.text.trim();
                  print(user.email);
                  user.password = _password.text;
                  user.username = _username.text;
                  bloc.register(user).then((value){
                    if(value == "ok"){
                      saveHiveUser(user);
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                    }
                  });
                  ///register
                }, 
                child: Text("Confirmer")
              )
            ],
          ),
        )
      ),
    );
  }
}