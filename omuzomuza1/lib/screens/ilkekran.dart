import 'package:flutter/material.dart';
import 'Giris.dart';

class IlkEkran extends StatefulWidget {
  @override
  State<IlkEkran> createState() => _IlkEkranState();
}

class _IlkEkranState extends State<IlkEkran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        shadowColor: Colors.lightGreen,
        title: Text(style: TextStyle(fontSize: 24), "Omuz Omuza"),
      ),
      body: buildGiris(),
    );
  }

  Widget buildGiris() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.lightGreen,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadiusDirectional.circular(35)
            ),

            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
            padding: EdgeInsets.all(40),
            child: Text(
              "'İyilik Düşünmek Bizi Cesaretle Yaşatır' (Goethe) Hoşgeldiniz:)",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white12),
                    child: Container(
                      child: Text("Hadi Giriş Yapalım :)"),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => Giris()));
                    }
                ),
              ),


            ],
          )
        ]

    );
  }

}