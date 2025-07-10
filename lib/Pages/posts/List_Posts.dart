import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/services/UserService.dart';
import 'package:smart_shopk4/view_model/List_Posts_View_Model/List_Post_View_Model.dart';
import 'package:intl/intl.dart';
class ListPosts extends StatefulWidget {
  final List<PostModel> post;
  final int initialIndex;

  const ListPosts({super.key, required this.post, required this.initialIndex});

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = Provider.of<ListPostViewModel>(context, listen: false);
      viewModel.fetchPostsAndUsers(widget.post);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListPostViewModel>(context);
    final isLoading = viewModel.isLoading;
    final posts = viewModel.posts;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Ionicons.chevron_back),
        ),
        centerTitle: true,
        title: Text('Posts', style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: ScrollController(
          initialScrollOffset: widget.initialIndex * 300.0,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final user = viewModel.getUserById(post.ownerId);
          final formattedDate = post.timestamp != null
              ? DateFormat('d MMMM').format(post.timestamp!.toDate())
              : '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: user?.photoUri != null &&
                      user!.photoUri!.isNotEmpty
                      ? NetworkImage(user.photoUri!)
                      : AssetImage('assets/default_avatar.png') as ImageProvider,
                ),
                title: Text(user?.userName ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(post.description ?? ''),
              ),
              const SizedBox(height: 5),
              Image.network(
                post.mediaUrl ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(formattedDate),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}

/*

 */