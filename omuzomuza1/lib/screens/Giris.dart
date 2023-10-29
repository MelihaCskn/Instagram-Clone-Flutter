import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omuzomuza1/screens/sifremi_unuttum.dart';
import 'package:omuzomuza1/screens/tapbarcontroller.dart';

import 'Kayit.dart';



class Giris extends StatefulWidget {

  @override
  State<Giris> createState() => _Giris();
}

class _Giris extends State<Giris> {
  late String email,sifre;
  final formkey=GlobalKey<FormState>();
  final firebaseAuth=FirebaseAuth.instance;

  void _login() async {

    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      try {
        UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: sifre,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TapBarController()));
      } catch (e) {
        print('Giriş işlemi başarısız oldu: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: Text(
                  'Giriş işlemi başarısız oldu. Lütfen geçerli bir e-posta ve şifre girin.'),
              actions: [
                TextButton(
                  child: Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
backgroundColor: Colors.blueGrey,
          title: Text("OMUZ OMUZA"),
        ),
        body:
        SingleChildScrollView(
            child:
            Form(
              key:formkey,
              child:
              Container(
                margin: EdgeInsets.only(left: 10,top: 30,right: 20),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Icon(Icons.lock,size: 100),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hoşgeldiniz :)",style: TextStyle(fontSize: 25),)
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex:2,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.all(
                                  Radius.circular(8)
                                )
                              ),
                              margin: EdgeInsets.only(left: 20,top: 40),
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Lütfen Emailinizi Giriniz";
                                  }
                                },
                                onSaved: (value){
                                  email=value!;
                                },

                                decoration: InputDecoration(
                                    hintText: " Email"
                                ),
                              ),
                            )),],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex:2,
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)
                                    )
                                ),
                                margin: EdgeInsets.only(left: 20,top: 20),   //conteinerın ekrana olan dıştaki uzaklık
                                child: TextFormField(
                                  obscureText: true,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Lütfen sifre giriniz";
                                    }
                                  },
                                  onSaved: (value){
                                    sifre=value!;
                                  },

                                  decoration: InputDecoration(
                                      hintText: " Sifre"
                                  ),
                                )
                            )),
                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 40,right: 40,top: 40),
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(primary:Colors.grey[700]),
                              child: Text("Giriş Yap",style: TextStyle(color:Colors.white),),
                            ),
                          ),
                        )
                      ],
                    ),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex:2,
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text("HESABINIZ YOK MU?",style: TextStyle(color: Colors.blueGrey),),
                            )),
                        Expanded(
                            flex:2,
                            child:  Container(
                              margin: EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Kayit()));
                                   },
                                style: ElevatedButton.styleFrom(primary:Colors.grey[700]),
                                child: Text("Kayıt Ol",style: TextStyle(color:Colors.white),),
                              ),
                            )
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child:Container(
                              margin: EdgeInsets.only(left: 40,right: 40),
                              child: TextButton(
                                onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                                },
                                child: Text("Şifremi Unuttum",style: TextStyle(color: Colors.blueGrey),
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),))
    );

  }
}
