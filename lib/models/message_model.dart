import 'package:myfirstapp/models/user.dart';
class MessageModel {
  String userGetter;
  String userSender;
  String keySender;
  String messageContent;
  MessageModel({this.userSender, this.keySender,this.userGetter,this.messageContent});
  factory MessageModel.fromJson(data, key){
    return MessageModel(
      userSender: data['userSender'],
      messageContent: data['messageContent'],
      userGetter: data['userGetter'],
      keySender: key
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "userSender": userSender,
      "messageContent": messageContent
    };
  }


}