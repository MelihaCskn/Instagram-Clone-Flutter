import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'EtkinlikEkle.dart';
import 'Etkinliklerim.dart';
import 'Menu.dart';
import 'profiliDüzenle.dart';

class Profil extends StatefulWidget {
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Stream<DocumentSnapshot> documentstrem = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.email)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
      ),
      drawer: Menu(),
        backgroundColor: Colors.blueGrey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EtkinlikEkle()));
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: documentstrem,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data!.exists) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(children: [
                  SizedBox(height: 40),
                  Icon(Icons.person, size:60),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kullanıcı Bilgileri",
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilDuzenle()));
                            },
                            icon:
                                Icon(Icons.settings, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 3, right: 3, bottom: 8, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "İsim Soyisim ve ya Kurum Adı",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 3, right: 3, bottom: 8, top: 8),
                          child: Row(
                            children: [
                              Text(
                                data['Isim_soyisim_veya_kurum_adi'].toString(),
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 3, right: 3, bottom: 8, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "mail",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 3, right: 3, bottom: 8, top: 8),
                          child: Row(
                            children: [
                              Text(
                                data["email"].toString(),
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 3, right: 3, bottom: 8, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "hakkimizda",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 3, right: 3, bottom: 8, top: 8),
                          child: Row(
                            children: [
                              Text(
                                data['hakkimizda'].toString(),
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ]);
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
