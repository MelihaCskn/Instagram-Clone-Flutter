import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omuzomuza1/screens/Etkinliklerim.dart';
import 'package:omuzomuza1/screens/Giris.dart';
import 'package:omuzomuza1/screens/Profil.dart';


class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State {
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(

            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.emoji_people_sharp,
                    color: Colors.white,
                    size: 90.0,
                  ),
                  Text(
                    "OMUZ OMUZA",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Kullanıcı Bilgileri'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Profil()));
            },
          ),

          ListTile(
            leading: Icon(Icons.content_paste_sharp),
            title: Text('Etkinliklerim'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Etkinliklerim()));
            },
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış'),
            trailing: Icon(Icons.arrow_right),
            onTap: () async{
    final shouldPop=await showMyDialog();

    }

          ),

        ],
      ),
    );
  }
  Future<bool?> showMyDialog() =>showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Çıkış yapmak istediğinize emin misiniz?"),
          actions: [
            TextButton(
              child: Text('Evet'),
              onPressed: () =>  auth.signOut().whenComplete(() {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Giris()),
                        (Route<dynamic> route) => false);
              })
            ),
            TextButton(
              child: Text('Hayır'),
              onPressed: () =>Navigator.pop(context,true)
 
            ),
          ],
        );
      }
  );

}