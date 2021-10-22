import 'package:flutter/material.dart';

class ConnexionPage extends StatefulWidget {
  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                  width: 100,
                   height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/chatImage.png"),
                    ),
                    shape: BoxShape.circle,
                  ),
                  
                ),
                SizedBox(height: 20,),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 5,end: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Container>[
                    Container(
                      color: Color(0xFF6CEC4C),
                      width: MediaQuery.of(context).size.width*.47,
                      height: 50,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/register');
                        }, 
                        child: Text(
                          "S'INSCRIRE",
                          style: TextStyle(
                            color: Colors.white
                          )
                        )
                      ),
                    ),
                    
                     Container(
                       color: Color(0xFF6CEC4C),
                      width: MediaQuery.of(context).size.width*.47,
                      height: 50,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/login');
                        }, 
                        child: Text(
                          "SE CONNECTER",
                          style: TextStyle(
                            color: Colors.white
                          )
                        )
                      ),
                    )
                  ]
                ),
              )
            ],
          ),
        ),
      );
  }
}