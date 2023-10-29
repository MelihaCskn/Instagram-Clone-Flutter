import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:omuzomuza1/modeller/etkinlik.dart';


class Anasayfa extends StatefulWidget{


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Etkinlikler').snapshots();


  Widget build(BuildContext context) {
  
    return WillPopScope (
  onWillPop:()async {
    final shouldPop=await showMyDialog();
    return shouldPop ?? false;
  },
     child: Scaffold(
       appBar: AppBar(

         backgroundColor: Colors.grey[700],
       ),
         backgroundColor: Colors.blueGrey,
        body:
        StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              return !snapshot.hasData
                  ? CircularProgressIndicator()
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

    } )));
  }

 Future<bool?> showMyDialog() =>showDialog<bool>(
   context:context,
   builder:(context)=>AlertDialog(
     title: Text("Çıkış yapmak istediğinize emin misiniz"),
     actions: [
       TextButton(
         child: Text('Evet'),
         onPressed: () => Navigator.pop(context, true),
       ),
       TextButton(
         child: Text('Hayır'),
         onPressed: () => Navigator.pop(context, false),
       ),
     ],
   )
 );


}