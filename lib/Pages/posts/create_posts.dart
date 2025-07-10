import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Pages/Components/Buttons/customButton.dart';
import 'package:smart_shopk4/Pages/Components/custom_image.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/view_model/posts_view_model/posts_view_model.dart';

class CreatePosts extends StatefulWidget {
  const CreatePosts({super.key});

  @override
  State<CreatePosts> createState() => _CreatePostsState();
}

class _CreatePostsState extends State<CreatePosts> {
  @override
  Widget build(BuildContext context) {
    PostsViewModel viewModel = Provider.of<PostsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              viewModel.resetPost();
              Navigator.pop(context);
            },

            icon: Icon(Ionicons.close_outline)
        ),
        backgroundColor: Colors.white,
        title: Text('Create Post',
        style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showImageChoice(context, viewModel);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.height * 0.8,
                    color: AppColors.primaryBlue500,
                    child: viewModel.imgLink != null
                      ? CustomImage(
                      imageurl: viewModel.imgLink,
                        width: MediaQuery.of(context).size.width,
                       height: MediaQuery.of(context).size.width - 30,
                       fit: BoxFit.cover,
                    )
                        : viewModel.mediaUrl == null
                      ?  Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                        : Image.file(
                      viewModel.mediaUrl!,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width - 30,
                      fit: BoxFit.cover,

                    )


                  ),

                ),

                SizedBox(height: 40,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    onChanged: (val) {
                      viewModel.setDescription(val);
                    },
                    initialValue: viewModel.description,
                    maxLines: 5,
                  decoration: InputDecoration(

                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: AppColors.primaryBlue500
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.primaryBlue500, width: 1.5)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.primaryBlue500, width: 1.5)
                    ),
                  ),
                  ),
                ),

                SizedBox(height: 10,),
                ListTile(

                  leading: Icon(CupertinoIcons.location, color: AppColors.primaryBlue500,),
                  title: Text('Add to Location', style:
                    TextStyle(
                      color: AppColors.primaryBlue500
                    ),),
                  onTap: () {},
                ),
                SizedBox(height: 30,),

                Consumer<PostsViewModel>(
                    builder: (context, viewModel, child) {
                      return SizedBox(
                        width: 350,
                        height: 50,
                        child: viewModel.loading
                         ? Center(child: CircularProgressIndicator(
                          color: AppColors.primaryBlue500,
                        ),)
                            : ElevatedButton(
                            onPressed: ()  async{
                              await viewModel.uploadPosts(context);
                              
                              if(context.mounted && !viewModel.loading) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Post uploaded successfully!'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue500,
                                shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                        ),
                            ),
                            child: Text(
                              'Upload Post',
                              style: TextStyle(
                                color: Colors.white, fontSize: 18
                              ),
                            )
                        )
                      );
                    }
                )

              ],
            ),
          )
      ),
    );
  }

  showImageChoice(BuildContext context, PostsViewModel viewModel) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext   context)
        {
          return FractionallySizedBox(
            heightFactor: 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Select Image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                ),
                Divider(),
                ListTile(
                  leading: Icon(Ionicons.camera_outline),
                  title: Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    viewModel.pickImage(camera: true);
                  },
                ),
                 ListTile(
                   leading: Icon(Ionicons.image),
                   title: Text('Gallery'),
                   onTap: () {
                     Navigator.pop(context);
                     viewModel.pickImage();
                   },
                 )
              ],
            ),
          );
        }
    );
  }
}

