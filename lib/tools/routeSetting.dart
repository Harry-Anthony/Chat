import 'package:flutter/material.dart';
import 'package:myfirstapp/bloc/homeBloc.dart';
import 'package:myfirstapp/bloc/loginBloc.dart';
import 'package:myfirstapp/bloc/messageBloc.dart';
import 'package:myfirstapp/bloc/profilBloc.dart';
import 'package:myfirstapp/bloc/registerBloc.dart';
import 'package:myfirstapp/bloc/searchBloc.dart';
import 'package:myfirstapp/page/connexion.dart';
import 'package:myfirstapp/page/home.dart';
import 'package:myfirstapp/page/message.dart';
import 'package:myfirstapp/page/profilPage.dart';
import 'package:myfirstapp/page/register.dart';
import 'package:myfirstapp/page/searchPage.dart';
import 'package:myfirstapp/tools/pageTranstion.dart';
import 'package:myfirstapp/page/login.dart';
import 'package:provider/provider.dart';
routeSetting(routeSettings){
  return PageRouteBuilder(
    settings: routeSettings,
    transitionDuration: const Duration(milliseconds: 100),
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
          return TransitionEffect.createSlide(
              animationTween: t1, secondaryAnimationTween: t3)(
          Curves.linear, animation, secondaryAnimation, child);
    },
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
      switch(routeSettings.name){
        case '/login':
          return ChangeNotifierProvider<LoginBloc>(
            create: (_)  => LoginBloc(),
            child: Login()
          );
          break;
        case '/home':
          return ChangeNotifierProvider<HomeBloc>(
            create: (_)=> HomeBloc(),
            child: Home()
          );
          break;
        case '/message':
          return ChangeNotifierProvider<MessageBloc>(
              create: (_) => MessageBloc(),
              child: MessagePage(),
          );
        case '/register':
          return ChangeNotifierProvider<RegisterBloc>(
            create: (_) => RegisterBloc(),
            child: Register()
          );
        case '/search':
          return ChangeNotifierProvider<SearchBloc>(
            create: (_) => SearchBloc(),
            child: SearchPage(),
          );
          break;
        case '/profil':
          return ChangeNotifierProvider<ProfilBloc>(
            create: (_) => ProfilBloc(),
            child: ProfilPage(),
          );
      }
      return ConnexionPage();
    }
  );
}