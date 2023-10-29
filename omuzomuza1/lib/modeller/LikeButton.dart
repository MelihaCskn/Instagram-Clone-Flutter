import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget{
  late final bool Begenildi;
  void Function()? ontap;
  LikeButton({super.key,required this.Begenildi,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:ontap,
      child:
        Icon(
          Begenildi ? Icons.favorite : Icons.favorite_border,
          color: Begenildi ? Colors.red : Colors.grey,

        )
       );
  }


}