import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matriomony/database.dart';
import 'package:matriomony/string_const.dart';
import 'package:matriomony/user.dart';
import 'package:matriomony/userDetails.dart';
import 'addUser.dart';

class UserList extends StatefulWidget {
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  User user = User();
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredUser = [];

  @override
  void initState() {
    super.initState();
    filteredUser = List.from(User.userList);
  }

  void searchUser(String searchData) {
    setState(() {
      if (searchData.isNotEmpty) {
        filteredUser = User.userList.where((user) {
          return user[NAME]
              .toString()
              .toLowerCase()
              .contains(searchData.toString().toLowerCase());
        }).toList();
      } else {
        filteredUser = List.from(User.userList);
      }
    });
  }


  String searchString = ""; // Store search input


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'User List',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          backgroundColor: Colors.blueGrey.shade100,
          elevation: 4,
        ),
        body: Column(
          children: [
            SizedBox(height: 8,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search),
                  hintText: 'Search here.......',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onChanged: searchUser
              ),
            ),
            SizedBox(height: 8,),
            Expanded(
                child: FutureBuilder(
                    future: user.getUserList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        // var users=snapshot.data!;

                        return Column(
                            children: [
                            SizedBox(height: 8),
                            User.userList.isNotEmpty
                                ? Expanded(
                              child: ListView.builder(
                                itemCount:
                                // searchController.text.isEmpty
                                //     ?
                                User.userList.length,
                                    // : filteredUser.length,
                                itemBuilder: (context, index) {
                                  var user = User.userList[index];
                                  // searchController.text.isEmpty
                                  //     ? User.userList[index]
                                  //     : filteredUser[index];

                                  return Center(
                                    child: Card(
                                      margin: EdgeInsets.symmetric(vertical: 6),
                                      elevation: 4,
                                      shadowColor: Colors.black26,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.95,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: user['GENDER']== 'Female'
                                              ? Colors.deepPurple.shade50
                                              : Colors.blueGrey.shade50,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor:
                                                  user['GENDER'] == 'Female' ?
                                                  Colors
                                                      .deepPurple.shade100
                                                      : Colors
                                                      .blueGrey.shade200,
                                                  child: Icon(
                                                      user['GENDER'] == "Female"
                                                          ? Icons.girl
                                                          : Icons.boy,
                                                      size: 22,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(width: 12),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        user['NAME'] ?? 'Unknown',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors
                                                              .purple.shade800,
                                                        ),
                                                      ),
                                                      Text(
                                                        user['EMAIL'] ??
                                                            'No Email',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .purple.shade600),
                                                      ),
                                                      Text(
                                                        user['PHONE']
                                                            .toString() ??
                                                            'N/A',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                            Colors.black87),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  onPressed: () async{
                                                    int newFav=(user['FAV'] ?? 0) == 1 ? 0 : 1 ;
                                                    // Update the favorite status in the database
                                                    await User().updateUser(
                                                        user['UserId'],
                                                        {MatrimonialDatabase.FAV: newFav}
                                                    );
                                                    //aa FAV change thya pachhi list update krva mate
                                                    // User.userList = await User().getUserList();
                                                    setState(() {});
                                                    print('USER FAVOURITE ::::::::::::::: ${user['FAV']}');

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
                                                        builder: (BuildContext
                                                        context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Are you sure to edit ?'),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'Cancel')),
                                                              TextButton(
                                                                  onPressed: () async {
                                                                    Navigator.of(context).pop();
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context)=>AddUser(userDetails: user,)
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text('Yes'))
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  icon: Icon(Icons.edit,
                                                      color: Colors.black),
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
                                                                    await this.user.deleteUser(user['UserId']);
                                                                    setState(() {
                                                                      User.userList.removeWhere((element) => element['id'] == user['UserId']);
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
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Viewing ${user['NAME']}\'s profile'),backgroundColor: Colors.grey,),
                                                    );
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Userdetails(
                                                              userDetails: user,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    user['GENDER'] == 'Female'
                                                        ? Colors.deepPurple
                                                        .shade200
                                                        : Colors.blueGrey
                                                        .shade200,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                    ),
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                  ),
                                                  child: Text(
                                                    "View Profile",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
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
                                style:
                                TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(child: Text('NO USER FOUND',style: TextStyle(color: Colors.grey),));
                      }
                    }
                    )
            )
          ],
        )
        );
  }
}


