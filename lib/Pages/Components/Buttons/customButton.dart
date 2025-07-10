import 'package:flutter/material.dart';

Widget customButton({required IconData? icon, required String text, required VoidCallback onTap})

{
  return GestureDetector(
    onTap: onTap,

    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.circular(8),
        border: Border.all(color: Colors.black12, width: 1),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(2, 2)
          )
        ]
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 20,),
          SizedBox(width: 8,),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
               fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    ),
  );
}