import 'package:flutter/material.dart';

class GoogleSignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignUpButton({super.key, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 372,
      child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
             side: const BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/Icons/google_icon.png'),
              SizedBox(width: 10,),
              Text('Sign up with Google',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              )

            ],

      )),
    );
  }
}
