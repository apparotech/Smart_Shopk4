import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Pages/OtherUserProfilePage/OtherUserProfilePage.dart';
import 'package:smart_shopk4/view_model/UserSearchViewModel/UserSearchViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/view_model/UserSearchViewModel/UserSearchViewModel.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel =  Provider.of<UserSearchViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7F9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onTap: () {
                          viewModel.setSearchFocused(true);
                },
                          onChanged: (value) {
                            viewModel.search(value);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search people',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),


            Expanded(
              child: Consumer<UserSearchViewModel>(
                builder: (context, viewModel, _) {
                  if (!viewModel.isSearchFocused) {
                    // 🧱 Masonry Grid (default view)
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MasonryGridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset('assets/Homepage/srk.jpg'),
                          );
                        },
                      ),
                    );
                  } else {
                    
                     final users = viewModel.users;
                     if(users.isEmpty ) {
                       return Center(child: Text('Start typing to search users'),);
                     }
                    return ListView.builder(
                      itemCount: viewModel.users.length,
                      itemBuilder: (context, index) {
                        final user = viewModel.users[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: user.photoUri != null && user.photoUri!.isNotEmpty
                                ? NetworkImage(user.photoUri!)
                                : AssetImage('assets/default_user.png') as ImageProvider,
                          ),
                          title: Text(user.userName ?? ''),
                          onTap: () {
                            // navigate to user profile or detail screen
                            Navigator.push(context, MaterialPageRoute(builder: (_) => OtherUserProfilePage(userId: user.id!)));
                          },
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

