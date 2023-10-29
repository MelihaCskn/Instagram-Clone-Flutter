import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modeller/etkinlik.dart';

class Etkinliklerim extends StatefulWidget{
  @override
  State<Etkinliklerim> createState() => _EtkinliklerimState();
}

class _EtkinliklerimState extends State<Etkinliklerim> {
  late String baslik,icerik,adres,kullaniciid;
  FirebaseAuth auth=FirebaseAuth.instance;

  @override

  Widget build(BuildContext context) {
    FirebaseAuth auth=FirebaseAuth.instance;
Query etkinliklerim=FirebaseFirestore.instance.collection("Etkinlikler").
where("kullaniciid",isEqualTo: auth.currentUser!.uid);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
        ),
        backgroundColor: Colors.blueGrey,
        body:
        StreamBuilder<QuerySnapshot>(
            stream: etkinliklerim.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              return !snapshot.hasData
                  ? Etkinlik_yok()
                  : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index) {
                    DocumentSnapshot etkinlik=snapshot.data!.docs[index];
                    return Etkinlik(
                      email: etkinlik["email"].toString(),
                      icerik: etkinlik["icerik"].toString(),
                      ihtiyac: etkinlik["ihtiyac"].toString(),
                      adres: etkinlik["adres"].toString(),
                      begeniler:List<String>.from(etkinlik["Begeniler"] ?? []),
                      etkinliktime: etkinlik["etkinliktime"].toString(),
                      etkinlikid: etkinlik.id,) ;
                  });

            }) );
  }

 Widget Etkinlik_yok() {
    return
        Center(
          child: Text("Henüz Etkinlik Eklemediniz"),
        );
 }






}

