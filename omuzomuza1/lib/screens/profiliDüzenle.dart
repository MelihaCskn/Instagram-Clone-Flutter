import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilDuzenle extends StatefulWidget{
  @override
  State<ProfilDuzenle> createState() => _ProfilDuzenleState();
}

class _ProfilDuzenleState extends State<ProfilDuzenle> {
  late String Isim_soyisim_veya_kurum_adi,hakkimizda,email;
  final formkey=GlobalKey<FormState>();
  final firebaseFirestore=FirebaseFirestore.instance;
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

   return Scaffold(
       appBar: AppBar(
         title: Text("Profil Bilgileri"),
         backgroundColor: Colors.blueGrey,
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
                       Text("Profil Düzenle:)",style: TextStyle(fontSize: 30),),

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
                                   return "İsim soyisim veya kurum adi giriniz";
                                 }
                               },
                               onSaved: (value){
                                 Isim_soyisim_veya_kurum_adi=value!;
                               },
                               decoration: InputDecoration(
                                   hintText: "İsim soyisim veya kurum adi"
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
                                 validator: (value){
                                   if(value!.isEmpty){
                                     return "Hakkınızda bilgiler ekleyiniz";
                                   }
                                 },
                                 onSaved: (value){
                                   hakkimizda=value!;
                                 },
                                 decoration: InputDecoration(
                                     hintText: "Hakkınızda"
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
                             onPressed: () {
                               String res;

                               if(formkey.currentState!.validate()) {
                                 formkey.currentState!.save();
                               }
                               else{}
                               final users =  firebaseFirestore
                                   .collection("users").doc(auth.currentUser!.email)
                                   .set({
                                 'kullaniciid':auth.currentUser!.uid,
                                 'email':auth.currentUser!.email,
                                 'Isim_soyisim_veya_kurum_adi':Isim_soyisim_veya_kurum_adi,
                                 'hakkimizda':hakkimizda,

                               });
                               ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content:Text("Profil Bilgileriniz Başarıyla Kaydedildi")
                                 ),);

                               Navigator.pushReplacementNamed(context, "/TapbarController");
                             },
                             style: ElevatedButton.styleFrom(primary:Colors.grey[700]),
                             child: Text("Profil kaydet",style: TextStyle(color:Colors.white),),

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