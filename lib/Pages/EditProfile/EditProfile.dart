import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/services/validation_service.dart';
import 'package:smart_shopk4/utils/firebase.dart';
import 'package:smart_shopk4/view_model/edit_profile_view_model/edit_profile_view_model.dart';


class EditProfile extends StatefulWidget {


  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

 // UserModel? user;

  @override
  void initState() {
    super.initState();
    Future.microtask(()=>
        Provider.of<EditProfileViewModel>(context, listen:  false).fetchUserData());

  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditProfileViewModel>(context);
    final user = viewModel.user;

    return Scaffold(
      key: viewModel.scaffoldKey,
      appBar:
      AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: AppColors.primaryBlue500,

          ),

        ),
        actions: [
          IconButton(
              onPressed: () {
                viewModel.editProfile(context);
              },
              icon: Icon(Icons.done,
                color: Colors.black
                ,
                size: 20,
              )
          )
        ],

      ),

      body: user ==null
      ? Center(child: CircularProgressIndicator(),)

      : Form(
        key: viewModel.formKey,
          child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {

                    },
                    child: Text('Edit',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    ),)
                )
              ],
            ),
            SizedBox(height: 5,),
            Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Homepage/profile.jpg'),
                      fit: BoxFit.cover
                  ),

              ),
            ),

            SizedBox(height: 20,),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              child:TextFormField(
               initialValue: user.userName ?? "",
                onSaved: viewModel.setUsername,

                validator: (value) {
                  if( value == null || value.isEmpty) {
                    return'please Enter the username';
                  } else if(ValidationService.userName(value)) {
                    return 'Please Enter the <1 username';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(

                 // labelText: 'Username',
                 labelStyle: TextStyle(
                   color: AppColors.primaryBlue500
                 ),
                 //hintText: 'username',
                 // hintStyle: TextStyle(
                   // color: Colors.black
                 // ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5),
                    ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5)
                  )

                ),
              ),
            ),
             SizedBox(height: 20,),
            Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: TextFormField(

                initialValue: user.bio ?? " ",
                onSaved: viewModel.setBio,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Your bio',
                  labelStyle: TextStyle(
                    color: AppColors.primaryBlue500,

                  ),
                  hintText: 'Write the something',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5),
                    ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),

                    borderSide: BorderSide(color: AppColors.primaryBlue500, width: 1.5)
                  )
                ),
              ),
            )


          ],
        ),
      ))
          /*
      SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text(
                    "Profile Picture",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold

                    ),
                  ),
                ),

                SizedBox(width: 200,),
                TextButton(
                    onPressed: () {} ,
                    child: Text("Edit", style:
                      TextStyle(

                        color: AppColors.primaryBlue500,

                      ),)
                )
              ],

            ),

            SizedBox(height: 5,),
            Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Homepage/profile.jpg'),
                  fit: BoxFit.cover
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2
                      ,
                    spreadRadius: 5,
                    offset: Offset(2, 2)
                  ),
                ]
              ),
            ),

            SizedBox(height: 30,),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),

            SizedBox(height: 5,),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Bio',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),

                ),






              ],


            ),

            Center(
              child: Text(
                  'Deccribe Yourself...'
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Divider(
              thickness: 1,
              color: Colors.black,
            ),

            SizedBox(height: 10,),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'UserName',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                ),




              ],


            ),

            Center(
              child: Text(
                  'UserName'
              ),
            ),

            SizedBox(height: 50,),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),





          ],
        ),
      ),
      
           */
    );
  }
}
