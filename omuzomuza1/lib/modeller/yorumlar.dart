import 'package:flutter/material.dart';

class Yorumlar extends StatelessWidget {
  late final String yorum;
  late final String kullanici;
  late final String time;
  Yorumlar({super.key,
  required this.yorum,
  required this.kullanici,
  required this.time});

  @override
  Widget build(BuildContext context) {
  return

    Padding(
      padding: const EdgeInsets.only(right: 8,left: 8),
      child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[300],
      ),
      margin: EdgeInsets.only(bottom: 9),
      padding: EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(yorum),
          SizedBox(height: 5,),
          Row(
            children:[
            Text(kullanici,style: TextStyle(color: Colors.grey[600]),),
              Text("*",style: TextStyle(color: Colors.grey[600]),),
              Text(time,style: TextStyle(color: Colors.grey[600]))
        ]
          )
        ],
      ),
  ),
    );
  }
}
