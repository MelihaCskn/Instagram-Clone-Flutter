import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modeller/etkinlik.dart';

class Favorilerim extends StatefulWidget{
  @override
  State<Favorilerim> createState() => _FavorilerimState();
}

class _FavorilerimState extends State<Favorilerim> {
  late String baslik,icerik,adres,kullaniciid;
  FirebaseAuth auth=FirebaseAuth.instance;

  @override

  Widget build(BuildContext context) {
    FirebaseAuth auth=FirebaseAuth.instance;
    Query favorilerim=FirebaseFirestore.instance.collection("Etkinlikler")
        .where("Begeniler",arrayContains: auth.currentUser!.email);

    var size=MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
        ),
        backgroundColor: Colors.blueGrey,
        body:
        StreamBuilder<QuerySnapshot>(
            stream: favorilerim.snapshots(),
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

