import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapi_matriomony/user.dart';
import 'package:restapi_matriomony/userList.dart';

import 'aboutUs.dart';
import 'addUser.dart';
import 'favourite.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  // Function to update the user list
  void updateUserList(List<Map<String, dynamic>> updatedList) {
    setState(() {});
  }

  void addUserToFavourite() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text(
            'Matrimonial',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Stack(children: [
        // Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/images/couple_4.png'),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        // // make image blur
        // BackdropFilter(
        //   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur
        //   child: Container(
        //     color: Colors.black.withOpacity(0), // No overlay, just blur
        //   ),
        // ),

        Padding(
          padding: const EdgeInsets.all(18.0),
          child: GridView.count(
            padding: const EdgeInsets.all(15),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddUser(); // Navigate to AddUser screen
                      },
                    ),
                  );
                },
                child: Card(
                  color: Colors.deepPurple.shade100,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.person_add_solid,
                        color: Colors.black,
                        size: 40,
                      ),
                      SizedBox(height: 5),
                      Text('Add User'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserList();
                      },
                    ),
                  );
                },
                child: Card(
                  color: Colors.blueGrey.shade100,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.square_list,
                        color: Colors.black,
                        size: 40,
                      ),
                      SizedBox(height: 5),
                      Text('User List'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Favourite();
                    },
                  ));
                },
                child: Card(
                  color: Colors.pink.shade100,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.heart_circle_fill,
                        color: Colors.black,
                        size: 40,
                      ),
                      SizedBox(height: 5),
                      Text('Favourite'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return AboutUsPage();
                    },
                  ));
                },
                child: Card(
                  // color: Colors.purple.shade100,
                  color: Color(0xFFD1B2D1),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.person_crop_square,
                        color: Colors.black,
                        size: 40,
                      ),
                      SizedBox(height: 5),
                      Text('About Us'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // ),
      ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 4,
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.home, color: Colors.black54,size: 30,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>DashBoard()));
                },
              ),
              IconButton(
                icon: Icon(CupertinoIcons.heart, color: Colors.pink.shade200,size: 30,),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>Favourite()));
                },
              ),
              SizedBox(width: 40), // add button mateni space
              IconButton(
                icon: Icon(CupertinoIcons.person_crop_square, color: Colors.blueGrey.shade300,size: 30,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>UserList()));
                },
              ),
              IconButton(
                icon: Icon(CupertinoIcons.info_circle_fill, color: Colors.deepPurple.shade200,size: 30,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>AboutUsPage()));
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade100,
        child: Icon(CupertinoIcons.add, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddUser();
              },
            ),
          );
        },
      ),

    );
  }
}
