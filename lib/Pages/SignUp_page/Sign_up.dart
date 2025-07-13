import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/Components/Buttons/GoogleSignUpButton.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/SignIn_Page/Sign_inPage.dart';

import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shopk4/services/validation_service.dart';
import 'package:smart_shopk4/view_model/signup_view_model/signup_view_model.dart';
import 'package:provider/provider.dart';
class SignUp extends StatelessWidget {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
 // final _formKey = GlobalKey<FormState>();

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SignupViewModel viewModel = Provider.of<SignupViewModel>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
          backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Form(
              key: viewModel.formKey,
              child: SingleChildScrollView(
                child: Column(
                 children: [
                   const SizedBox(
                     height: 60,
                   ),
                    Center(
                     child: Text(
                       'Sign up',
                         style: GoogleFonts.poppins(
                           color: Colors.black,
                           fontSize: 40,
                           fontWeight: FontWeight.bold,
                         )
                     )
                   ),
                   SizedBox(height: 30,),

                   Padding(
                       padding:  const EdgeInsets.symmetric(horizontal: 20),
                     child: TextFormField(
                       validator: (value) {
                         if(value == null || value.isEmpty) {
                           return 'Please enter the valide Name';
                         }
                       },
                       onSaved: (String? val) {
                         viewModel.setUserName(val);
                       },
                       focusNode: viewModel.usernameFN,
                       textInputAction: TextInputAction.next,
                       onFieldSubmitted: (_) {
                         FocusScope.of(context).requestFocus(viewModel.emailFN);
                       },
                       decoration: InputDecoration(
                   
                         labelText: 'Name',
                         labelStyle: const TextStyle(
                           color: AppColors.primaryBlue500
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(8),
                           borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(8),
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
                            if(value == null|| value.isEmpty) {
                              return 'Email is required';
                            } else   if (!ValidationService.email(value)) {
                              return'Invalid email format';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (String? val) {
                            viewModel.setEmail(val);
                          },
                          focusNode: viewModel.emailFN,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(viewModel.passFN);
                          },
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
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: TextFormField(
                       validator: (value) {
                         if(value == null|| value.isEmpty ) {
                           return'Please Enter The Password';
                         } else if(!ValidationService.password(value)) {
                           return'Plase Enter Password Greater than 6 ';
                         } else {
                           return null;
                         }
                       },
                       onSaved: (String? val) {
                           viewModel.setPassword(val);
                       },
                       focusNode: viewModel.passFN,
                       textInputAction: TextInputAction.next,
                       onFieldSubmitted: (_) {
                         FocusScope.of(context).requestFocus(viewModel.CPassFN);
                       },
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

                       ),
                     ),

                   ),

                   SizedBox(height: 20,),

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: TextFormField(
                       validator: (value) {
                         if(value == null|| value.isEmpty ) {
                           return'Please Enter The Password';
                         } else if(!ValidationService.password(value)) {
                           return'Plase Enter Password Greater than 6 ';
                         } else {
                           return null;
                         }
                       },
                       onSaved: (String? val) {
                         viewModel.setcPassword(val);
                       },
                       decoration: InputDecoration(
                         labelText: 'ConformPassword',
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

                       ),
                     ),

                   ),

                   SizedBox(height: 20,),

                   Padding(padding: const EdgeInsets.symmetric(horizontal: 20),

                     child: SizedBox(
                       width: 350,
                       height: 50,

                       child: ElevatedButton(
                           onPressed: () {
                         viewModel.register(context);

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

                   SizedBox(height: 10,),

                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                           "Already have an account?",
                         style: TextStyle(color: Colors.grey),
                       ),
                       TextButton(
                           onPressed: (){
                             NavigationHelper.nextPage(context, SignInPage());
                           },
                           child: Text("Log in")
                       )
                     ],
                   ),

                   SizedBox(height: 20,),

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Row(
                         children: [
                           Expanded(
                             child: Divider(
                               thickness: 1,



                               color:Colors.grey,

                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 5),
                             child: Text("or"),
                           ),
                           Expanded(child: Divider(color: Colors.grey,))
                         ],
                       ),
                   ),

                   SizedBox(height: 20,),
                   GoogleSignUpButton(onPressed: () {

                   })



                 ],

                ),
              )
          )
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

    /*
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




     */


