

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:thesocials/functions/login_signup.dart';
import 'package:thesocials/signup.dart';

import '../functions/dimensions.dart';


class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
    TextEditingController emailtxt = TextEditingController();

  TextEditingController passwordtxt = TextEditingController();
bool isloading =false;
  LoginSignup login=LoginSignup();

  @override
  Widget build(BuildContext context) {
    return isloading==false? Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: Dimensions.screenheight,
            child: Column(
              children: [
                Container(
                  height: Dimensions.Static_margins_and_paddings(
                      Dimensions.screenheight, 400),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 30),
                        width: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 80),
                        height: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 200),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/light-1.png'))),
                        ),
                      ),
                      Positioned(
                        left: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 140),
                        width: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 80),
                        height: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 150),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/light-2.png'))),
                        ),
                      ),
                      Positioned(
                        right: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 40),
                        top: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 40),
                        width: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 80),
                        height: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 150),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/clock.png'))),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.Static_margins_and_paddings(
                                  Dimensions.screenheight, 50)),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      Dimensions.Static_margins_and_paddings(
                                          Dimensions.screenheight, 40),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      Dimensions.Static_margins_and_paddings(
                          Dimensions.screenheight, 30)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(
                            Dimensions.Static_margins_and_paddings(
                                Dimensions.screenheight, 5)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(
                                  Dimensions.Static_margins_and_paddings(
                                      Dimensions.screenheight, 8)),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[100]!))),
                              child: TextField(
                                controller: emailtxt,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email ",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  Dimensions.Static_margins_and_paddings(
                                      Dimensions.screenheight, 8)),
                              child: TextField(
                                controller: passwordtxt,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 30),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromRGBO(143, 148, 251, .6)),),
                          onPressed: (() {
                            setState(() {
                              isloading=true;
                            });
                            
                           login.login(emailtxt.text, passwordtxt.text, context);
                          }),
                          child: 
                          const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                      ),
                      
                      SizedBox(
                        height: Dimensions.Static_margins_and_paddings(
                            Dimensions.screenheight, 70),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Forgot Password?",
                              style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1))),
                          SizedBox(
                            width: Dimensions.Static_margins_and_paddings(
                                Dimensions.screenheight, 10),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Get.to(Signup());
                            }),
                            child: const Text("Signup",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1))),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )):Container(child: const Center(child: CircularProgressIndicator()),);
  }
}