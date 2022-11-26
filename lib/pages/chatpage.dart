import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:thesocials/functions/datahandleling.dart';
import 'package:thesocials/pages/homepage.dart';

class Chatpage extends StatefulWidget {
  
  final String reciveremail;
  final String username;
  

  Chatpage({super.key, required this.reciveremail, required this.username,});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  TextEditingController chatController=TextEditingController();
 
 var ola;
  @override
  Widget build(BuildContext context) {
   
     return Scaffold(
      backgroundColor:  const Color.fromRGBO(175, 122, 197,100),
      body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Row(children: [
            IconButton(onPressed: (() {
           
              Get.to(Homepage());
            }), icon:const Icon(Icons.arrow_back_ios)),
            Text(widget.username,style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.none),
            
            
            ),
            const SizedBox(),
            IconButton(onPressed:()async {
            
            }, icon: Container(
              height:40,width:40,
              decoration: BoxDecoration( color:Colors.black12 ,borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.call),)),
             
             
              IconButton(onPressed:() {
              
            }, icon: Container(
              height:40,width:40,
              decoration: BoxDecoration( color:Colors.black12 ,borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.videocam),))
            ],),
        ),
        const SizedBox(height: 30,),
        Chatbody(widget.reciveremail),
        chatchat(chatController,context,widget.reciveremail,widget.username)
        
        
      ],
    ),);}
}

Widget Chatbody(reciveremail){
  return Expanded(
    child: Container(
      width: double.infinity,
    
    
      decoration: const BoxDecoration(color:Colors.white, borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),

              //TODO:chat item to be used
      
    ),
    child:StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.email).collection('messages').doc(reciveremail).collection('chats').orderBy('time',descending: true).snapshots(),
      builder: ((context,AsyncSnapshot snapshot) {
        print(snapshot.data.docs[0]['sender']);
       if(snapshot.hasData){
      
          return ListView.builder(
            reverse: true,
            itemCount:snapshot.data.docs.length  ,
            physics:const BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
           
             if(snapshot.data.docs[index]['sender']==FirebaseAuth.instance.currentUser!.email){
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  chatitem(snapshot.data.docs[index]['message'],snapshot.data.docs[index]['time'],),
                ],
              );
             }else{
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                  
                      chatitem(snapshot.data.docs[index]['message'],snapshot.data.docs[index]['time'],),
                    ],
                  ),
                ],
              );
             }
          
          }));
    
       }else{return Container();}
    }),)
  ));
}

  Widget chatchat(chatcontroler,context,reciveremail,username) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        color: Colors.white,
        child: TextField(
          controller: chatcontroler,
          decoration: InputDecoration(
            hintText: 'Type your message...',
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: (() {
                  if(chatcontroler!=null){
                 
                    Provider.of<Datahandle>(context,listen: false).Chat(chatcontroler.text,reciveremail,username);
                    chatcontroler.clear();
                  }
                }),
                child: Container( 
                     
                
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.indigo),
                  padding: const EdgeInsets.all(14),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.all(20),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
Widget chatitem(messages,time,){
  return Column(
    children: [
      Container(
      
        decoration: BoxDecoration(color:Color.fromRGBO(175, 122, 197  ,50),borderRadius: BorderRadius.circular(30) ),
        child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(messages),
      ),),
      Row(

        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(time,style: TextStyle(fontSize: 8),),
        ],
      ),
      SizedBox(height: 20,)
    ],
  );
}