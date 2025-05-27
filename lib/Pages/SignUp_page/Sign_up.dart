import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/Components/Buttons/GoogleSignUpButton.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';

class SignUp extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();


  SignUp({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _editText(textEditingController, 'Name', ),

              const SizedBox(height: 10,),
              _editText(emailEditingController, 'Email', ),

              const SizedBox(height: 10,),

              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.visibility_off, color: AppColors.primaryBlue500,),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: AppColors.primaryBlue500,
                      fontWeight: FontWeight.bold,
                      
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.primaryBlue500,width: 2
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.primaryBlue500, width: 1.5
                      ),

                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              
              Padding(padding: const EdgeInsets.only(
                top: 20, left: 10, right: 10,
                bottom: 1
              ),
                child: SizedBox(
                  width: 373,
                  height: 50,
                  
                  child: ElevatedButton(
                      onPressed: () {}, 
                      style: ElevatedButton.styleFrom(

                        backgroundColor: AppColors.primaryBlue500,
                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(8),
                          
                        )
                      ),
                      child: Text('Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20

                      ),)
                  ),
                ),
              ),
             // SizedBox(height: ,),
              Padding(
                padding: const EdgeInsets.symmetric(

                  horizontal: 91
                ),
                child: Row(
                  children: [
                    Text('Already have an account?',

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                      )
                    ),
                    TextButton(
                        onPressed:() {} ,
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: AppColors.primaryBlue500,
                            fontSize: 14
                          ),
                        )
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,

                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5
                      ),
                      child: Text('or',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,


                      ),),
                    ),
                    Expanded(
                        child: Divider(

                        )
                    )


                  ],
                ),
              ),

              Padding(
                  padding:  const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10
                  ),
                child: GoogleSignUpButton(
                    onPressed: () {}
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _editText(TextEditingController? controller, String? label,) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(

          labelText: label,

          labelStyle: const TextStyle(color: AppColors.primaryBlue500),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}





