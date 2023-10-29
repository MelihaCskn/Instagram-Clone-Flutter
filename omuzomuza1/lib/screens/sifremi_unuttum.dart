import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omuzomuza1/screens/Giris.dart';
import 'package:omuzomuza1/screens/Kayit.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  @override


  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Şifre Sıfırlama Emaili Yollanmıştır")));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Giris()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Kullanıcı Bulunamadı");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kayıtlı bir email bulunamadı")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Şifremi Unuttum"),
        ),
        body:
        SingleChildScrollView(
            child:
            Form(
                key:_formKey,
                child:
                Container(
                  margin: EdgeInsets.only(left: 10,top: 70,right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hoşgeldiniz :)",style: TextStyle(fontSize: 25),)
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex:2,
                              child: Container(
                                margin: EdgeInsets.only(left: 20,top: 40,bottom: 40),
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
                              )),],
                      ),

                      Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                          });
                          resetPassword();
                        }
                      },
                      child: Text("Emaili Yolla")),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Giris()));
                      },
                      child: Text(
                        "Giriş",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bir hesabınız yok mu?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Kayit()));
                      },
                      child: Text(
                        "Kaydol",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      )),
                ],
              ),
            ],
          ),

      ),

    )
    ));

  }
}