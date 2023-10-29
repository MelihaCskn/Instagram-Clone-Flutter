

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Kayit extends StatefulWidget {

  @override
  State<Kayit> createState() => _KayitState();
}

class _KayitState extends State<Kayit> {
  late String email,sifre,Isim_soyisim_veya_kurum_adi;
  final formkey=GlobalKey<FormState>();
  final firebaseAuth=FirebaseAuth.instance;
  final firebaseFirestore=FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Text("Haydi Kayıt Olalım"),
        ),
        body:
        SingleChildScrollView(
            child:Form(
              key:formkey,
              child:
              Container(
                margin: EdgeInsets.only(left: 10,top: 80,right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("YENİ HESAP",style: TextStyle(fontSize: 25),)
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex:2,
                            child: Container(
                              margin: EdgeInsets.only(left: 20,top: 20),
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
                                    hintText: "Email"
                                ),
                              ),
                            )),
                      ],
                    ),





                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex:2,
                            child: Container(
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
                                      hintText: "Sifre"
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
                            margin: EdgeInsets.all(40),
                            child: ElevatedButton(
                              onPressed: () async{

                                  if(formkey.currentState!.validate()) {
                                    formkey.currentState!.save();
                                  }
                                  else{}

                                    var result = await firebaseAuth.createUserWithEmailAndPassword
                                      (email: email, password: sifre);
                                    formkey.currentState!.reset();
                                  final resultData = await firebaseFirestore
                                      .collection("users").doc(firebaseAuth.currentUser!.email)
                                      .set({
                                    "email":email,
                                    "sifre":sifre,


                                  });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content:Text("Kullanıcı Başarıyla Kaydedildi,giriş sayfasına yönlendiriliyorsunuz")
                                    ),);

                                Navigator.pushReplacementNamed(context, "/Giris");
                              },
                              style: ElevatedButton.styleFrom(primary:Colors.grey[700]),
                              child: Text("Kayıt Ol",style: TextStyle(color:Colors.white),),

                            ),
                          ),
                        )
                      ],
                    ),


                  ],
                ),
              ),))
    );

  }


}
