
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:thesocials/pages/chatpage.dart';

import '../functions/datahandleling.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController searchcontroller =TextEditingController();
  bool searching=false;
  bool searched=false;


  @override
  Widget build(BuildContext context) {
    return searching == false ?Scaffold(
      backgroundColor: const Color.fromRGBO(175, 122, 197,100) ,
      floatingActionButton:FloatingActionButton(
      backgroundColor:  const Color.fromRGBO(93, 173, 226,100),
      onPressed: (() {
        
      setState(() {
        print(Provider.of<Datahandle>(context,listen: false).searchedUser['email']);
        searching=true;
        searched=false;

      });
    }),child: const Icon(Icons.search),),
    body: FutureBuilder(
      future: Provider.of<Datahandle>(context).getuserProfile(),
      builder:((context, snapshot)  { return Column(children: [
        const SizedBox(height: 90,),
        Row(
          children: [
            const SizedBox(width: 20,),
            const Text('Welcome ',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.none),),
            Text(Provider.of<Datahandle>(context).userProfile['username']+",",style: const TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.none),)
          ],
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [Row(children: [const Text('Email:',style: TextStyle(color: Colors.white54),),Text(Provider.of<Datahandle>(context).userProfile['email'],style: const TextStyle(color: Colors.white54))],),
          const SizedBox(height: 3,),
          Row(children: [const Text('Phone:',style: TextStyle(color: Colors.white54)),Text(Provider.of<Datahandle>(context).userProfile['phoneno'],style: const TextStyle(color: Colors.white54))],)]),)
,        homeBody()
      ]);
   } ),
      )):  Scaffold(
         backgroundColor: const Color.fromRGBO(175, 122, 197,100) ,
         floatingActionButton:FloatingActionButton(
          child: const Icon(Icons.search),
      backgroundColor:  const Color.fromRGBO(93, 173, 226,100),
      onPressed: (() {
      setState(() {
        searching=false;
      });

   } )),
   body: Column(children: [
        const SizedBox(height: 90,),
        Row(
          children: [
            const SizedBox(width: 20,),
            const Text('Welcome ',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.none),),
            Text(Provider.of<Datahandle>(context).userProfile['username']+",",style: const TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.none),)
          ],
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [Row(children: [const Text('Email:',style: TextStyle(color: Colors.white54),),Text(Provider.of<Datahandle>(context).userProfile['email'],style: const TextStyle(color: Colors.white54))],),
          const SizedBox(height: 3,),
          Row(children: [const Text('Phone:',style: TextStyle(color: Colors.white54)),Text(Provider.of<Datahandle>(context).userProfile['phoneno'],style: const TextStyle(color: Colors.white54))],),],),)
,    Expanded(
    child: Container(
      width: double.infinity,
       
      decoration: const BoxDecoration(color:Colors.white, borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),

          
      
    ),
    child:Column(children: [
      const SizedBox(height: 10,),
      Container(
        width: 400,
        height: 50,
        child: TextField(
          controller: searchcontroller,
          decoration: InputDecoration(hintText: 'Search.....',suffixIcon: Container(
            width: 100,
            child: Row( mainAxisAlignment: MainAxisAlignment.end, children: [IconButton(
              
              onPressed: (() { if(searchcontroller.text!=Provider.of<Datahandle>(context,listen: false).userProfile['username']) {
                Provider.of<Datahandle>(context,listen: false).Searchfunction(searchcontroller.text);
              };
              

              if(Provider.of<Datahandle>(context,listen: false).searchedUser!=null){setState(() {
                searched=true;
              });}
            
        }), icon: const Icon(Icons.search,color: Color.fromRGBO(35, 155, 86  ,100),),iconSize: 30,),
        
        IconButton(onPressed: (() {
            
    setState(() {
      searching=false; 
      searched=false;
    });    }), icon: const Icon(Icons.exit_to_app,color: Color.fromRGBO(231, 76, 60  ,100),),)],),
          ), enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: 2, color: Color.fromRGBO(133, 193, 233,100)), 
        borderRadius: BorderRadius.circular(50.0),
    ),),),
      ),
      const SizedBox(height: 30,),
    searched==true && Provider.of<Datahandle>(context,listen: false).searchedUser!={}?  Usersearched(Provider.of<Datahandle>(context).searchedUser['username'],Provider.of<Datahandle>(context).searchedUser['email'],Provider.of<Datahandle>(context,).searchedUser['phoneno'],context):Container()
      
      
    ],)
  ))
      ]),
   
   );
  
  
  }
}
Widget homeBody(){
  return Expanded(
    child: Container(
      width: double.infinity,
    
    
      decoration: const BoxDecoration(color:Colors.white, borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),

          //Text(snapshot.data!.docs[0]['sender']);
      
    ),
    child:StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.email).collection('messages').snapshots(),
      builder: (context, snapshot) {
      if(snapshot.hasData){
      return    ListView.builder( itemCount:snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
          return  Column(children: [const SizedBox(height:10),usreChat(snapshot.data!.docs[index]['reciver'], snapshot.data!.docs[index]['lastmsg'], snapshot.data!.docs[0]['time'],  snapshot.data!.docs[index]['username'])]);
          }
         
          ));
      
      
      }else{return Container();}
    },)));
}
Widget Usersearched(name,email,phone,context){
return Container(
  height: 100,
  width: double.infinity,
  decoration: BoxDecoration(color: const Color.fromRGBO(236, 240, 241,100),borderRadius: BorderRadius.circular(30)),
  child:Row(children: [
    const SizedBox(width: 10,),
    Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: const Color.fromRGBO(93, 173, 226  ,100)),
      child: Center(child: Text("@"+name,style:const TextStyle(overflow: TextOverflow.clip,color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),),

      const SizedBox(width: 20,),
     
      Column(children: [
        const SizedBox(height: 30,),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [const Text('Email:',style: TextStyle(color: Colors.black54),),Text(email,style: const TextStyle(color: Colors.black54))],),
          const SizedBox(height: 3,),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [const Text('Phone:',style: TextStyle(color: Colors.black54)),Text(phone,style: const TextStyle(color: Colors.black54))],),],),
          const SizedBox(width: 30,),
          IconButton(onPressed: (() {
            Get.to(Chatpage(reciveremail: email,username: Provider.of<Datahandle>(context,listen: false).searchedUser['username'],));
          }), icon: const Icon(Icons.chat_bubble,size: 30,color: Color.fromRGBO(21, 67, 96,100),))
  ]) ,
  
  );
}


Widget usreChat(email,lastmsg,time,username){
 return Container(
  height:90 ,
  width: double.infinity,
decoration: const BoxDecoration(color: Color.fromRGBO(235, 222, 240  ,100)),
child: Row(
  children: [
    const SizedBox(width: 10,),
     Container(

      height: 70,
      width: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: const Color.fromRGBO(130, 224, 170  ,100)),
      child:  Center(child: Text("@"+'$username',style:const TextStyle(overflow: TextOverflow.clip,color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),),
      const SizedBox(width: 5,),
      Column(
        
        children: [
          const SizedBox(height: 20,),
          Text(email),
          const SizedBox(height: 10,),
          Row(
            children: [
              const SizedBox(width: 10,),
              Container(width: 100,height:15 ,child:  Align(
                alignment: Alignment.bottomLeft,
                child: Text('You:'+"$lastmsg",style: const TextStyle(overflow: TextOverflow.ellipsis,fontSize: 13,color: Colors.black38),)),),
                Text(time,style: const TextStyle(color: Colors.black38,fontSize: 10)),
            ],
          ),
        ],
      ),
      Expanded(child: Container()),
      Row(
     
        children: [
          IconButton(onPressed: (() {
            Get.to(Chatpage(reciveremail: email,username: username,));
          }), icon: const Icon(Icons.chat_bubble,size: 32,color: Color.fromRGBO(21, 67, 96,100),)),

          const SizedBox(width: 25,)
        ],
      )

   
  ],
),

 );
}