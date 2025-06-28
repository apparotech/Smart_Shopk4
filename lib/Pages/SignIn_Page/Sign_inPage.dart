import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Pages/Components/Buttons/GoogleSignUpButton.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/SignUp_page/Sign_up.dart';
import 'package:smart_shopk4/services/validation_service.dart';
import 'package:smart_shopk4/view_model/signin_view_model/sign_in_view_model.dart';

import '../const/Colors/AppColor.dart';

class SignInPage extends StatelessWidget {


   SignInPage({super.key});


  @override
  Widget build(BuildContext context) {
    SignInViewModel viewModel = Provider.of<SignInViewModel>(context);


    return Scaffold(
      key: viewModel.scaffoldKey,
      backgroundColor: Colors.white,

      body: SafeArea(
          child: Form(
            key: viewModel.formKey,
              child:SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.purple,
                              fontSize: 30,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                      ),
                    ),

                    Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          "Welcome back! Please enter your details"
                          , style: TextStyle(
                          color: Colors.black,

                        ),
                        ),
                      ),
                    ),

                    SizedBox(height: 40,),
                    GoogleSignUpButton(onPressed: (){}),

                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Or",
                              style: TextStyle(
                                  color: Colors.grey
                              ),
                            ),


                          ),
                          Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              )
                          )
                        ],
                      ),
                    ),
                     SizedBox(height: 30,),
                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        validator:  (value) {
                         if(value == null || value.isEmpty) {
                           return 'Email is required';
                         } else if(!ValidationService.email(value)) {
                           return 'Invalid email format';
                         }
                        },
                        onSaved: (String? val) {
                          viewModel.setEmail(val);
                        },
                        //focusNode: viewModel.emailFN,
                        textInputAction: TextInputAction.next,

                        decoration: InputDecoration(

                            labelText: 'Email',
                            labelStyle: const TextStyle(
                              color: AppColors.primaryBlue500,

                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:  BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5)
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                        ),
                      ),
                    ),


                    SizedBox(height: 20,),
                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        validator:  (value) {
                        if(value == null || value.isEmpty) {
                          return'Please Enter the Password';
                        } else if (!ValidationService.password(value)) {
                          return 'Please Enter the Correct Password';
                        } else {
                          return null;
                        }
                        },
                        onSaved: (String? val) {
                         viewModel.setPassword(val);
                        },
                        //focusNode: viewModel.emailFN,
                        textInputAction: TextInputAction.next,

                        decoration: InputDecoration(

                            labelText: 'Password',
                            suffixIcon: Icon(Icons.visibility_off),
                            labelStyle: const TextStyle(
                              color: AppColors.primaryBlue500,

                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:  BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5)
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: (){},
                              child: Text('Forgot password',
                                style: TextStyle(
                                  color: AppColors.primaryBlue500
                                ),
                              )
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30,),

                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20),

                      child: SizedBox(
                        width: 350,
                        height: 50,

                        child: ElevatedButton(
                            onPressed: () {
                              print('raj');
                             viewModel.login(context);

                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                              ),
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                            )
                        ),
                      ) ,
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.grey,

                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              NavigationHelper.nextPage(context, SignUp());

                            },
                            child: Text('Sign up',
                            style: TextStyle(
                              color: AppColors.primaryBlue500
                            ),)
                        )
                      ],
                    )
                  ],
                ),
              )
          )

      ),

      );

  }
}
