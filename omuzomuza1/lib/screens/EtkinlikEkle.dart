import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class EtkinlikEkle extends StatefulWidget {

  @override
  State<EtkinlikEkle> createState() => _EtkinlikEkleState();
}

class _EtkinlikEkleState extends State<EtkinlikEkle> {

  late final String baslik;
  late final String icerik;
  late final String adres;
  late final String time;
  late final String ihtiyac;
  late final String etkinliktime;
  final formkey = GlobalKey<FormState>();
  final firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Etkinlik Ekleyelim"),
        ),
        body:
        SingleChildScrollView(
            child: Form(
              key: formkey,
              child:
              Container(
                margin: EdgeInsets.only(left: 10, top: 80, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Bilgilerin Açık ve Anlaşılır Olması Çok Önemli !"),

                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                margin: EdgeInsets.only(left: 20, top: 20),
                                //conteinerın ekrana olan dıştaki uzaklık
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Lütfen etkinliğinizin içeriği hakkında bilgi veriniz";
                                    }
                                  },
                                  onSaved: (value) {
                                    icerik = value!;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "içerik"
                                  ),
                                )
                            )),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                margin: EdgeInsets.only(left: 20, top: 20),
                                //conteinerın ekrana olan dıştaki uzaklık
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Lütfen etkinliğinizin konumu hakkında bilgi veriniz";
                                    }
                                  },
                                  onSaved: (value) {
                                    adres = value!;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "adres"
                                  ),
                                )
                            )),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                margin: EdgeInsets.only(left: 20, top: 20),
                                //conteinerın ekrana olan dıştaki uzaklık
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Lütfen etkinlik için neye ihtiyaç var bilgi veriniz";
                                    }
                                  },
                                  onSaved: (value) {
                                    ihtiyac = value!;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Bu etkinlik için neye ihtiyaç var?"
                                  ),
                                )
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                margin: EdgeInsets.only(left: 20, top: 20),
                                //conteinerın ekrana olan dıştaki uzaklık
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Lütfen etkinliğinizin zamanı hakkında bilgi veriniz";
                                    }
                                  },
                                  onSaved: (value) {
                                    etkinliktime = value!;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "9 eylül 2024"
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
                              onPressed: () async {

                                if (formkey.currentState!.validate()) {
                                  formkey.currentState!.save();
                                }
                                else {}
                         FirebaseFirestore.instance.collection("Etkinlikler")
                             .add({
                         'icerik':icerik,
                         'adres':adres,
                         'kullaniciid':auth.currentUser!.uid,
                           "email":auth.currentUser!.email,
                         'ihtiyac':ihtiyac,
                         'etkinliktime':etkinliktime,
                           "TimeStamp": Timestamp.now(),
                           "Begeniler":[]
                         });


                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      "Etkinlik Başarıyla Kaydedildi")
                                  ),);

                                Navigator.pushReplacementNamed(
                                    context, "/TapBarController");
                              },
                              style: ElevatedButton.styleFrom(primary: Colors
                                  .grey[700]),
                              child: Text("Etkinliği Ekle",
                                style: TextStyle(color: Colors.white),),

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