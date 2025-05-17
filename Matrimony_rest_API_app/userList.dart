import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapi_matriomony/apiService.dart';
import 'package:restapi_matriomony/user.dart';
import 'package:restapi_matriomony/userDetails.dart';
import 'addUser.dart';

class UserList extends StatefulWidget {
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ApiService apiUser=ApiService();
  User user = User();
  late int age;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredUser = [];

  @override
  void initState() {
    super.initState();
    getList();
  }

  Future<void> getList() async {
    User.userList = List.from(await User().getUserList());
    filteredUser = List.from(User.userList);
    setState(() {});
  }

  void searchUser(String searchData) {
    String searchData=searchController.text;
    setState(() {
      if (searchData.isNotEmpty) {
        filteredUser = User.userList.where((user) {
          return user['name']
              .toString()
              .toLowerCase()
              .contains(searchData.toString().toLowerCase());
        }).toList();
      } else {
        filteredUser = List.from(User.userList);
      }
    });
  }


  void sortBy_name_a_to_z(){
    setState(() {
      filteredUser.sort((a,b) => a['name'].toString().toLowerCase().compareTo(b['name'].toString().toLowerCase()));
    });
  }

  void sortBy_name_z_to_a(){
    setState(() {
      filteredUser.sort((a,b) => b['name'].toString().toLowerCase().compareTo(a['name'].toString().toLowerCase()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'User List',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          backgroundColor: Colors.blueGrey.shade100,
          elevation: 4,
          actions: [
            IconButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text(
                            'Sort by : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(CupertinoIcons.textformat_abc),
                                title: Text('Name (Z-A)'),
                                onTap: (){
                                  sortBy_name_a_to_z();
                                  Navigator.pop(context);
                                },
                                trailing: Icon(CupertinoIcons.arrow_down,color: Colors.blueGrey,),
                              ),
                              ListTile(
                                leading: Icon(CupertinoIcons.textformat_abc),
                                title: Text('Name (A-Z)'),
                                onTap: (){
                                  sortBy_name_z_to_a();
                                  // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => UserList(),));
                                  Navigator.pop(context);
                                },
                                trailing: Icon(CupertinoIcons.arrow_up,color: Colors.blueGrey,),
                              ),
                            ],
                          ),
                        );
                      }
                      );
                },
                icon: Icon(CupertinoIcons.sort_down,size: 30,color: CupertinoColors.darkBackgroundGray,))
          ],
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
                onChanged: (value){
                  searchUser(value);
                }
              ),
            ),
            SizedBox(height: 8,),
            Expanded(
                child: FutureBuilder(
                    future: apiUser.getAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      else if (snapshot.hasData) {
                        List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(snapshot.data!);
                        if (User.userList.isEmpty){
                          User.userList=dataList;
                          filteredUser=List.from(User.userList);
                        }
                        return Column(
                            children: [
                            SizedBox(height: 8),
                            filteredUser.isNotEmpty
                                ? Expanded(
                              child: ListView.builder(
                                itemCount: filteredUser.length,

                                itemBuilder: (context, index) {
                                  var user = filteredUser[filteredUser.length-index-1];

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
                                          color: user['gender']== 'Female'
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
                                                  user['gender'] == 'Female' ?
                                                  Colors
                                                      .deepPurple.shade100
                                                      : Colors
                                                      .blueGrey.shade200,
                                                  child: Icon(
                                                      user['gender'] == "Female"
                                                          ? Icons.female
                                                          : Icons.male,
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
                                                        user['name'] ?? 'Unknown',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors
                                                              .purple.shade800,
                                                        ),
                                                      ),
                                                      Text(
                                                        user['email'] ??
                                                            'No Email',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .purple.shade600),
                                                      ),
                                                      Text(
                                                        user['phone']
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
                                                  onPressed: () async {
                                                    // Toggle the favorite status
                                                    bool newFav = (user['fav'] ?? false) == true ? false : true;

                                                    print('FAVORITE USER IS ::::: ${user['fav']}');

                                                    // Optimistically update the local user object for instant UI update
                                                    setState(() {
                                                      user['fav'] = newFav; // Update user object directly
                                                    });

                                                    // Update favorite status in the API
                                                    await ApiService().updateData(user['id'], {'fav': newFav});

                                                    // Fetch updated user list from API
                                                    List<Map<String, dynamic>> updatedUsers = await ApiService().getAllUsers();

                                                    // Update UI with new list
                                                    setState(() {
                                                      filteredUser = List.from(updatedUsers);
                                                    });
                                                  },
                                                  icon: Icon(
                                                    user['fav'] == true ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                                                    color: user['fav'] == true ? Colors.pink.shade200 : Colors.black45,
                                                  ),
                                                ),

                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text('Are you sure to edit?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text('Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () async {
                                                                Navigator.of(context).pop();
                                                                // Log the user data before navigating
                                                                print('Navigating to AddUser  with user: $user');
                                                                Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => AddUser (userDetails: user),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text('Yes'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
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
                                                                    print('::::::::::::::::::::::::::::::::::::ID IS ::::::::::::::::::::::${user['id']}');
                                                                    await apiUser.deleteData(user['id']);
                                                                    User.userList = await  apiUser.getAllUsers();
                                                                    setState(() {
                                                                      User.userList.removeWhere((element) => element['id'] == user['UserId']);
                                                                      filteredUser = List.from(User.userList);
                                                                      searchController.text='';
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
                                                            'Viewing ${user['name']}\'s profile'),backgroundColor: Colors.grey,),
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
                                                    user['gender'] == 'Female'
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


