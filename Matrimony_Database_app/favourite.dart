import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matriomony/string_const.dart';
import 'package:matriomony/user.dart';

import 'addUser.dart';
import 'database.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  TextEditingController searchController = TextEditingController();
  List<Map<String,dynamic>> favouriteUser=[];

  void initState(){
    super.initState();
    getFavouriteUser();
  }


  Future<void> getFavouriteUser() async{
    User.userList = await User().getUserList();
    setState(() {
      favouriteUser = User.userList.where((user) => user['FAV'] == 1).toList();
    });
  }
  void searchUser(String searchData){
    String searchData=searchController.text.toString().toString();
    setState(() {
      favouriteUser=User.userList.where((user) {
        return user['FAV'] == 1 &&
            user['NAME'].toString().toLowerCase().contains(searchData.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(
          child: const Text(
            'Favourite User',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/heart_3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // make image blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur
            child: Container(
              color: Colors.black.withOpacity(0), // No overlay, just blur
            ),
          ),
          Column(
            children: [
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.search),
                        hintText: 'Search favourite here.......',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onChanged: searchUser,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              favouriteUser.isNotEmpty
                  ? Expanded(
                child: ListView.builder(
                  itemCount: favouriteUser.length,
                  itemBuilder: (context, index) {
                    var user = favouriteUser[index];
                    return Center(
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        elevation: 4,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.purple.shade200,
                                    child: Icon(Icons.person, size: 22, color: Colors.white),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user['NAME'] ?? 'Unknown',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple.shade800,
                                          ),
                                        ),
                                        Text(
                                          user['EMAIL'] ?? 'No Email',
                                          style: TextStyle(fontSize: 14, color: Colors.purple.shade600),
                                        ),
                                        Text(
                                          user['PHONE'].toString() ?? 'N/A',
                                          style: TextStyle(fontSize: 14, color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are you want to remove from favourite ?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Cancel')),
                                                TextButton(
                                                    onPressed: () async {
                                                      int newFav=(user['FAV'] ?? 0) ==1 ? 0 :1;

                                                      // Update the favorite status in the database
                                                      await User().updateUser(
                                                          user['UserId'],
                                                          {MatrimonialDatabase.FAV: newFav}
                                                      );

                                                      //aa FAV change thya pachhi list update krva mate
                                                      User.userList = await User().getUserList();
                                                      setState(() {
                                                        favouriteUser = User.userList.where((user) => user['FAV'] == 1).toList();
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Yes'))
                                              ],
                                            );
                                          });

                                    },
                                    icon: Icon(
                                      user['FAV'] == 1
                                          ? CupertinoIcons
                                          .heart_fill
                                          : CupertinoIcons.heart,
                                      color: user['FAV'] == 1
                                          ? Colors.pink.shade200
                                          : Colors.black45,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are you sure to edit ?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddUser(
                                                                  userDetails:
                                                                  user),
                                                        ),
                                                      ).then((updatedUser) {
                                                        if (updatedUser !=
                                                            null) {
                                                          setState(() {
                                                            User.userList[index] = updatedUser;
                                                          });
                                                        }
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Text('Yes'))
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.edit, color: Colors.black),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext
                                          context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are you want to delete ?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                          context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                        'Cancel')),
                                                TextButton(
                                                    onPressed: () async {
                                                      await User().deleteUser(user['UserId']);
                                                      setState(() {
                                                        favouriteUser.removeWhere((element) => element['id'] == user['UserId']);
                                                      });
                                                      Navigator.of(context).pop(); // Close dialog after deletion
                                                    },
                                                    child:
                                                    Text('Yes'))
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(
                                        CupertinoIcons.delete_solid,
                                        color: Colors.black),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Viewing ${user[NAME]}\'s profile')),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple.shade100,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    child: Text(
                                      "View Profile",
                                      style: TextStyle(fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(
                child: Text(
                  "User data is not available",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}
