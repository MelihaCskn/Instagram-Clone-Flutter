import 'package:flutter/material.dart';

class YorumButton extends StatelessWidget {
  late final void Function()? onTap;
  YorumButton({super.key,
  required this.onTap});

  @override
  Widget build(BuildContext context) {
return GestureDetector(
  onTap: onTap,
  child: Icon(Icons.comment,
  color: Colors.blueGrey,),
);
  }
}