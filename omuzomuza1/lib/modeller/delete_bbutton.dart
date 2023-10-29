
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget{
  final void Function()? onTap;
  DeleteButton({super.key,required this.onTap});
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     child: Icon(
       Icons.delete,
       color: Colors.blueGrey,
     ),
   );
  }

}
