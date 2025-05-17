import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapi_matriomony/user.dart';
import 'package:restapi_matriomony/userDetails.dart';
import 'addUser.dart';
import 'apiService.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final ApiService apiUser=ApiService();

  TextEditingController searchController = TextEditingController();
  List<Map<String,dynamic>> favouriteUser=[];

  //make list only who are favourites
  void initState() {
    super.initState();
    favouriteUser = User.userList.where((user) => user['fav'] == true).toList();
  }


  void searchUser(String searchData){
    String searchData=searchController.text.toString();
    setState(() {
      favouriteUser=User.userList.where((user) {
        return user['fav'] == true &&
            user['name'].toString().toLowerCase().contains(searchData.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
            'Favourite User',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: Stack(
        children: [
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
                            color: user['gender']== 'Female'
                                ? Colors.deepPurple.shade50
                                : Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor:
                                    user['gender'] == 'Female' ?
                                    Colors
                                        .deepPurple.shade100
                                        : Colors
                                        .blueGrey.shade200,
                                    child: Icon(
                                        user['gender'] == "Female"
                                            ? Icons.girl
                                            : Icons.boy,
                                        size: 22,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user['name'] ?? 'Unknown',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple.shade800,
                                          ),
                                        ),
                                        Text(
                                          user['email'] ?? 'No Email',
                                          style: TextStyle(fontSize: 14, color: Colors.purple.shade600),
                                        ),
                                        Text(
                                          user['phone'].toString() ?? 'N/A',
                                          style: TextStyle(fontSize: 14, color: Colors.black87),
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 7,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Are you sure you want to remove from favourites?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(); // Close dialog
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context).pop(); // Close dialog first

                                                      // Toggle the favorite status
                                                      bool newFav = (user['fav'] ?? false) == true ? false : true;

                                                      // Update favorite status in the API
                                                      await ApiService().updateData(user['id'], {'fav': newFav});

                                                      // Fetch updated user list from API
                                                      List<Map<String, dynamic>> updatedUsers = await ApiService().getAllUsers();

                                                      // Update `User.userList` and filter `favouriteUser` again
                                                      setState(() {
                                                        User.userList = updatedUsers; // Update the main user list
                                                        favouriteUser = User.userList.where((user) => user['fav'] == true).toList();
                                                      });
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          user['fav'] == true ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                                          color: user['fav'] == true ? Colors.pink.shade200 : Colors.black45,
                                        ),
                                      ),
                                      //AA EDIT VADA BUTTON CHHE ***************************
                                      // IconButton(
                                      //   onPressed: () {
                                      //     showDialog(
                                      //         context: context,
                                      //         builder: (BuildContext context) {
                                      //           return AlertDialog(
                                      //             title: Text(
                                      //                 'Are you sure to edit ?'),
                                      //             actions: [
                                      //               TextButton(
                                      //                   onPressed: () {
                                      //                     Navigator.of(context)
                                      //                         .pop();
                                      //                   },
                                      //                   child: Text('Cancel')),
                                      //               TextButton(
                                      //                   onPressed: () {
                                      //                     Navigator.push(
                                      //                       context,
                                      //                       MaterialPageRoute(
                                      //                         builder: (context) =>
                                      //                             AddUser(
                                      //                                 userDetails:
                                      //                                 user),
                                      //                       ),
                                      //                     ).then((updatedUser){
                                      //                       if (updatedUser != null) {
                                      //                         setState(() {
                                      //                           User.userList[index] = updatedUser;
                                      //                         }
                                      //                         );
                                      //                       }
                                      //                       Navigator.of(context).pop();
                                      //                     }
                                      //                     );
                                      //                   },
                                      //                   child: Text('Yes'))
                                      //             ],
                                      //           );
                                      //         });
                                      //   },
                                      //   icon: Icon(Icons.edit, color: Colors.black),
                                      // ),
                                      // IconButton(
                                      //   onPressed: () {
                                      //     showDialog(
                                      //         context: context,
                                      //         builder: (BuildContext
                                      //         context) {
                                      //           return AlertDialog(
                                      //             title: Text(
                                      //                 'Are you want to delete ?'),
                                      //             actions: [
                                      //               TextButton(
                                      //                   onPressed: () {
                                      //                     Navigator.of(
                                      //                         context)
                                      //                         .pop();
                                      //                   },
                                      //                   child: Text(
                                      //                       'Cancel')),
                                      //               TextButton(
                                      //                   onPressed: () async {
                                      //                     await apiUser.deleteData(user['id']);
                                      //                     User.userList = await  apiUser.getAllUsers();
                                      //                     setState(() {
                                      //                       User.userList.removeWhere((element) => element['id'] == user['UserId']);
                                      //                       favouriteUser = List.from(User.userList);
                                      //                       searchController.text='';
                                      //                     });
                                      //                     Navigator.of(context).pop(); // Close dialog after deletion
                                      //                   },
                                      //                   child:
                                      //                   Text('Yes'))
                                      //             ],
                                      //           );
                                      //         });
                                      //   },
                                      //   icon: Icon(
                                      //       CupertinoIcons.delete_solid,
                                      //       color: Colors.black),
                                      // ),
                                      ElevatedButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Viewing ${user['name']}\'s profile')),
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
                                          backgroundColor: user['gender']== 'Female'
                                              ? Colors.deepPurple.shade200
                                              : Colors.blueGrey.shade200,
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
                              SizedBox(height: 7),
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
