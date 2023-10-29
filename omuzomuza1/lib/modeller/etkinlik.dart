
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omuzomuza1/helper/helper_method.dart';
import 'package:omuzomuza1/modeller/delete_bbutton.dart';
import 'package:omuzomuza1/modeller/yorumButon.dart';
import 'package:omuzomuza1/modeller/yorumlar.dart';


import 'LikeButton.dart';

class Etkinlik extends StatefulWidget {
  final String icerik,adres,ihtiyac,email,etkinliktime,etkinlikid;
  final List<String> begeniler;

  Etkinlik({super.key ,required this.icerik,required this.ihtiyac,
  required this.adres,required this.begeniler,required this.email,
    required this.etkinliktime,required this.etkinlikid});

  @override
  State<Etkinlik> createState() => _EtkinlikState();
}

class _EtkinlikState extends State<Etkinlik> {
  late final String icerik,adres,ihtiyac,email,etkinliktime,etkinlikid;
  FirebaseAuth auth=FirebaseAuth.instance;
  final currentUser=FirebaseAuth.instance.currentUser;
  bool Begenildi=false;
final _yorumTextController=TextEditingController();

  @override
  void initState(){
    super.initState();

    Begenildi=widget.begeniler.contains(currentUser!.email);
  }
  void begendimi(){
    setState(() {
      Begenildi=!Begenildi;
    });
    DocumentReference etkinlikref=FirebaseFirestore.instance.collection("Etkinlikler").doc(widget.etkinlikid);
    if(Begenildi){
      etkinlikref.update({
        "Begeniler":FieldValue.arrayUnion([currentUser!.email])
      });
    }else{
      etkinlikref.update({
        "Begeniler":FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }
void yorumEkle(String yorumText){
    FirebaseFirestore.instance.collection("Etkinlikler").doc(widget.etkinlikid).
    collection("Yorumlar").add({
      "YorumText":yorumText,
      "YorumYapan":currentUser!.email,
      "YorumTime":Timestamp.now()
    });
}
void yorumDiologGoster(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Yorum Ekle"),
      content: TextField(
        controller: _yorumTextController,
        decoration: InputDecoration(hintText: "Yorum Ekle"),
      ),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
      _yorumTextController.clear();
    },
            child: Text("Vazgeç")),
        TextButton(
            onPressed: (){
              yorumEkle(_yorumTextController.text);
              Navigator.pop(context);
              _yorumTextController.clear();
  },
              child: Text
            ("Gönder"))


      ],

    ));
}
void etkinlikSil(){
    showDialog(context: context,
        builder: (context)=>AlertDialog(
title: Text("Etkinlik Sil"),
          content: Text("Ekinliği silmek istediğinize emin misiniz ?"),
        actions: [
TextButton(onPressed: ()=>  Navigator.pop(context),
    child: Text("Vazgeç")),

          TextButton(onPressed: ()async{
       final yorumdoc= await FirebaseFirestore.instance.collection("Etkinlikler")
           .doc(widget.etkinlikid).collection("Yorumlar").get();
       for(var doc in yorumdoc.docs){
         await FirebaseFirestore.instance.collection("Etkinlikler")
             .doc(doc.id).delete();
       }
       FirebaseFirestore.instance.collection("Etkinlikler").
       doc(widget.etkinlikid).delete().
       then((value) => print("etkinlik silindi")).
       catchError((error)=>print("şu hata yakalandı: $error"));
       Navigator.pop(context);
          },

              child: Text("sil"))
        ],
        ));
}

  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
   return Padding(
     padding: EdgeInsets.all(12),
     child: InkWell(
       child: Container(
         decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(
                 color: Colors.black38, width: 2),
             borderRadius: BorderRadius.all(
                 Radius.circular(12))
         ),
         child: Padding(
           padding: EdgeInsets.all(6),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [



             SizedBox(height: 5,),

               Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Flexible(
                         fit: FlexFit.tight,
                         flex: 1,
                         child:
                         Icon(Icons.person,color: Colors.black,)),
                     Flexible(
                         fit: FlexFit.tight,
                         flex: 6,
                         child:
                         Text(widget.email,style: TextStyle(fontSize: 20,color: Colors.black),)),
                     if(widget.email==currentUser!.email)
                       DeleteButton(onTap: etkinlikSil),
           

                   ],
                 ),

               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Flexible(
                       fit: FlexFit.tight,
                       flex: 1,
                       child:
                       Icon(Icons.content_paste,color: Colors.black,)),
                   Flexible(
                       fit: FlexFit.tight,
                       flex: 6,
                       child:
                       Text(widget.icerik,style: TextStyle(fontSize: 15,color: Colors.black))),

                 ],
               ),

               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Flexible(
                       fit: FlexFit.tight,
                       flex: 1,
                       child:
                       Icon(Icons.location_on,color: Colors.black,)),
                   Flexible(
                       fit: FlexFit.tight,
                       flex: 6,
                       child:
                       Text(widget.adres,style: TextStyle(fontSize: 15,color: Colors.black),)),

                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Flexible(
                       fit: FlexFit.tight,
                       flex: 1,
                       child:
                       Icon(Icons.accessible_forward_rounded,color: Colors.black,)),
                   Flexible(
                       fit: FlexFit.tight,
                       flex: 6,
                       child:
                       Text(widget.ihtiyac,style: TextStyle(fontSize: 15,color: Colors.black),)),

                 ],
               ),


               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Flexible(
                       fit: FlexFit.tight,
                       flex: 1,
                       child:
                       Icon(Icons.access_time_rounded,color: Colors.black,)),
                   Flexible(
                       fit: FlexFit.tight,
                       flex: 6,
                       child:
                       Text(widget.etkinliktime,style: TextStyle(fontSize: 15,color: Colors.black),)),

                 ],
               ),




               SizedBox(height: 5,),


               Row(

                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Column(
                       children:[
                     LikeButton(Begenildi: Begenildi, ontap:begendimi),
                     SizedBox(height: 5,),
                     Text(widget.begeniler.length.toString())
             ]
                     ),

               SizedBox(width: 7,),
               Column(
                 children: [
                   YorumButton(onTap: yorumDiologGoster),
                   SizedBox(height: 5,),
                   Text("0",style: TextStyle(color: Colors.black),)
                 ],
               ),

                 ],
               ),


               StreamBuilder<QuerySnapshot>(
                 stream:FirebaseFirestore.instance.collection("Etkinlikler").
                 doc(widget.etkinlikid).collection("Yorumlar").
                 orderBy("YorumTime",descending: true).snapshots() ,
                   builder: (context,snapshot){
                   if(!snapshot.hasData){
                     return Center(
                       child: CircularProgressIndicator(),
                     );
                   }
                   return ListView(
          shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     children:
                       snapshot.data!.docs.map((doc){
                         final yorumData=doc.data() as Map<String, dynamic>;
                     return Yorumlar(
                         yorum: yorumData["YorumText"].toString(),
                         kullanici: yorumData["YorumYapan"].toString(),
                         time: formatDate(yorumData["YorumTime"])
                     );
                           }).toList(),

                   );
                   },
               )
             ],

           ),

         ),
       ),
     ),
   );
  }
}