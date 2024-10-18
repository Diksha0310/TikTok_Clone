import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/search_controller.dart';
import '../../models/user.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchUserController searchUserController = Get.put(SearchUserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onFieldSubmitted: (value) => searchUserController.searchUser(value),
          ),
        ),
        body: searchUserController.searchedUsers.isEmpty
            ? const Center(
          child: Text(
            'Search for users!',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : ListView.builder(
          itemCount: searchUserController.searchedUsers.length,
          itemBuilder: (context, index) {
            User user = searchUserController.searchedUsers[index];
            return InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(uid: user.uid),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.profilePhoto,
                  ),
                ),
                title: Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
