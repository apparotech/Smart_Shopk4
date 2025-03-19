import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 150,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  'Welcome!',
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
                  "Sign up to start your journey with books"
                      , style: TextStyle(
                  color: Colors.black,
                  
                ),
                ),
              ),
            ),
            
            SizedBox(height: 40,),
            
            Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(

                ),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.1)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Icon(Icons.facebook, color: Colors.purple,),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Text("Continue with Facebook"),
                        )
                      ],
                    )
                ),
              ),
            ),

            SizedBox(height: 10,),

            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(

                ),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.1)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Icon(Icons.facebook, color: Colors.red.shade600,),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Text("Continue with Google"),
                        )
                      ],
                    )
                ),
              ),
            ),

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

            SizedBox(height: 60,),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Your Email address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                  ),
                  fillColor: Colors.grey.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
            ),

            SizedBox(height: 10,),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Your Email address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  fillColor: Colors.grey.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
            ),

            SizedBox(height: 10,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20),

              child: SizedBox(
                width: 350,
                height: 50,

                child: ElevatedButton(
                    onPressed: () {

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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "By signing up or siging in , you agree to our Terms",


              ),

            ),
            Center(
              child: Text(
                  "of Use nad Privacy Policy"
              ),
            )



          ],
        ),
      ),
    );
  }
}
