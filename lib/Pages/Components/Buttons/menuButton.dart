import 'package:flutter/material.dart';

Widget menuButton({required IconData icon, required VoidCallback onTap}) {

  return GestureDetector(
    onTap: onTap,


      child: Container(
       padding: EdgeInsets.symmetric(horizontal: 9,vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12, width: 1),

          boxShadow: [
            BoxShadow(
              color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 1,
                offset: Offset(2, 2),

            ),

          ],

        ),
        child: Icon(icon, color: Colors.black,),
      ),

  );
}