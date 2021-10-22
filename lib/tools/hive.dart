
import 'package:hive/hive.dart';
import 'package:myfirstapp/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
}

initHiveBox() async {
  await initHive();
  await initHiveUser();
  await Hive.openBox<String>("uid");
  await Hive.openBox<String>("password");
}

initHiveUser() async {
  await Hive.openBox<User>("user");
}

saveHiveUser(User user) async {
  await Hive.box<User>("user").put("user", user);
}

saveHiveUid(String uid) async {
  await Hive.box<String>("uid").put("uid", uid);
} 

String getHiveUid(){
  return Hive.box<String>("uid").get("uid", defaultValue: null);
}

User getHiveUser(){
  User user =  Hive.box<User>("user").get("user",defaultValue: null);
  return user;
}
