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
              onPressed: ()  async {

                await viewModel.editProfile(context);
                Navigator.pop(context, true);
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
                    onPressed: () async{
                     showModalBottomSheet(
                         context: context,
                         builder: (context) => Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             ListTile(
                               leading: Icon(Icons.camera_alt),
                               title: Text('Camera'),
                               onTap: () {
                                 Navigator.pop(context);
                                 viewModel.pickImage(camera: true, context: context);
                               },
                             ),
                              ListTile(
                                leading: Icon(Icons.photo),
                                title: Text('Gallery'),
                                onTap: () {
                                  Navigator.pop(context);
                                  viewModel.pickImage(camera: false, context: context);
                                },
                              )
                           ],
                         )
                     );
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
             CircleAvatar(
               radius: 80,
               backgroundImage: viewModel.image != null
                   ? FileImage(viewModel.image!)
                   : (viewModel.user?.photoUri != null)
                   ? NetworkImage(viewModel.user!.photoUri!)
                   : AssetImage('assets/Homepage/profile.jpg'),



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
                  } else if(!ValidationService.userName(value)) {
                    return 'Please Enter the Greater than 1';
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


    );
  }
}
