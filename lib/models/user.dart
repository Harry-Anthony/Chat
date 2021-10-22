import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject{
   @HiveField(0)
   int id;
   @HiveField(1)
   String username;
   @HiveField(2)
   String email;
   String uid;
   String password;
   User({this.id,this.username,this.email,this.password, this.uid});
   factory User.fromJSON(data, key){
     return User(
       username: data['username'],
       email: data['email'],
       password: data['password'],
       uid: key
     );
   }
   Map<String, dynamic> toJson() => {
     "id": id,
     "username": username,
     "email": email,
     "password": password
   };
}