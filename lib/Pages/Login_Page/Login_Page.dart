import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/Add_Product/Add_Product.dart';
import 'package:smart_shopk4/Pages/Components/Naviagation_Page/Navigation_page.dart';
import 'package:smart_shopk4/Pages/InboxList/InboxList.dart';
import 'package:smart_shopk4/Pages/SignUp_page/Sign_up.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 140, top: 100, right: 120),
              child: Row(
                children: [
                  CircleAvatar(
                    
                    radius: 70,
                    backgroundColor: Colors.deepPurple,
                  )
                ],
              ),
            ),
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 4),
                  child: Text("Welcome Back",
                    style: TextStyle(color: Colors.black, fontSize: 20,
                      fontWeight: FontWeight.bold),),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide:BorderSide.none
                  ),
                  fillColor: Colors.grey.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.email)
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                  ),
                  fillColor: Colors.grey.withOpacity(0.1),
                  filled: true,
                    prefixIcon: const Icon(Icons.password),
                  suffixIcon: const Icon(Icons.post_add)
                  
                ),
              ),
            ),

            Padding(padding: const EdgeInsets.only(left: 10, right: 10, ),
              child: TextButton(
                  onPressed: () {


                  },
                  child: Text('Forgot password',
                      style: TextStyle(color: Colors.black, fontSize: 14))
              ),



            ),
            Padding(padding: const EdgeInsets.only(left: 10 , right: 10,),

              child: SizedBox(
                width: 350,
                height: 50,

                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) => AddProduct())

                      );
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
            Padding(padding: const EdgeInsets.only(left: 10, right: 10, top: 40),

              child: SizedBox(
                width: 350,
                height: 50,

                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.1),

                    ),
                    child: Text(
                      "Sign in with Google", style: TextStyle(color: Colors.black,fontSize: 15),
                    )
                ),
              ),
            ),
            
            Padding(padding: const EdgeInsets.only(left: 90, right: 10,),
              child: Row(
                children: [
                  Text("Don't have an account",
                    style: TextStyle(color: Colors.black,
                      fontSize: 14
                    ),),
                  TextButton(
                      onPressed: () {
                       GotoPage(anotherPage: SignUp(), context: context);
                       // Navigator.push(context,  MaterialPageRoute(builder: (context)=> SignUp(),),
                        //);
                      },
                      child: Text("sign Up",
                        style: TextStyle(color: Colors.purple,fontSize: 14
                        ),
                      )
                  )

                ],

              ),
            )


          ],
        ),
      ),


    );
  }


}
