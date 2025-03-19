import 'package:flutter/material.dart';

void GotoPage({required Widget anotherPage,  required BuildContext context }){
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=> anotherPage));
}