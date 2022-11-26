import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thesocials/pages/chatpage.dart';

import '../pages/homepage.dart';

class LoginSignup{

 Future login(email, password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (await FirebaseAuth.instance.currentUser != null) {
        Get.off(() => Homepage());
      
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title:const Text('Error'),
                content: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    children: [
                  const    Text('invalid email or password'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: (() {
                                Navigator.pop(context);
                              }),
                              child: Text('Ok')),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )));
    }
  }

void signup(email, phoneno, username, password, confirmpass) async {
    if (confirmpass == password) {
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Map<String, String> usermap = {
        "email": email,
        "username": username,
        'phoneno': phoneno,
        "password": password,
       
      };
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .set(usermap);

      //store data in firestore
    }
  }

}
