import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import  'package:intl/intl.dart';

class Datahandle extends ChangeNotifier{
var userProfile = {};
 var searchedUser={};
 List Chatusers=[];

 Future getuserProfile() async {
    var response = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
        userProfile=response.docs[0].data();
        notifyListeners();
     
   
    
  }
  Chatstate(reciveremail,message,time,username)async{
  await  FirebaseFirestore.instance.collection('Users').doc(
      FirebaseAuth.instance.currentUser!.email)
      .collection('messages').doc(reciveremail).set({"lastmsg":message,"time":time,"reciver":reciveremail,"username":username});

    await  FirebaseFirestore.instance.collection('Users').doc(
     reciveremail)
      .collection('messages').doc( FirebaseAuth.instance.currentUser!.email).set({"lastmsg":message,"time":time,"reciver":FirebaseAuth.instance.currentUser!.email,"username":username});
  }

  Chat(message,reciveremail,username)async{
   
    String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
    String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String time="$tdata";

  Chatstate(reciveremail, message, time, username);
    
   await  FirebaseFirestore.instance.collection('Users').doc(
      FirebaseAuth.instance.currentUser!.email)
      .collection('messages').doc(reciveremail)
      .collection('chats').add({'message':message,'time':time,'sender':FirebaseAuth.instance.currentUser!.email,'reciver':reciveremail});

await  FirebaseFirestore.instance.collection('Users').doc(reciveremail
     )
      .collection('messages').doc( FirebaseAuth.instance.currentUser!.email)
      .collection('chats').add({'message':message,'time':time,'sender':FirebaseAuth.instance.currentUser!.email,'reciver':FirebaseAuth.instance.currentUser!.email});
}

  Searchfunction(searchedUsername)async{
    var response = await FirebaseFirestore.instance.collection('Users').where('username',isEqualTo:searchedUsername ).get();
    searchedUser=response.docs[0].data();
    
notifyListeners();

  }



}
 