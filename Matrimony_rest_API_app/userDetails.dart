import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapi_matriomony/user.dart';

import 'addUser.dart';


class Userdetails extends StatefulWidget {

  Map<String, dynamic> userDetails;
  Userdetails({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {

  var color;

  //age calculate krvani method
  int calculateAge(String birthDateString) {

    // Split the date string into day, month, and year
    List<String> date = birthDateString.split("-");

    int day = int.parse(date[0]);
    int month = int.parse(date[1]);
    int year = int.parse(date[2]);

    // Create a DateTime object
    DateTime birthDate = DateTime(year, month, day);
    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;
    return age;
  }

  @override
  void initState(){
    super.initState();
    widget.userDetails['gender']=='Female' ? color=Colors.deepPurple.shade200: color=Colors.blueGrey.shade300;
  }
  //mnymdyghopndih bhuhfi
  Widget buildSection(String title, Map<String, dynamic> data) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Divider(color: color),
            ...data.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Text(
                    entry.value.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'User Details',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        backgroundColor: color,
      ),
      body: SingleChildScrollView(
      // var user=User.userList[index];
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: widget.userDetails['gender']=='Female' ? AssetImage('assets/images/girl1.png') : AssetImage('assets/images/boy.png')
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.userDetails['name'] ?? "User Name",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "User ID: ${widget.userDetails['id'] ?? "N/A"}",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Sections
            buildSection("About",{
              "Gender": widget.userDetails['gender'] ?? "N/A",
              "Date of Birth": widget.userDetails["date"] ?? "N/A",
              "Age": widget.userDetails['date'] != null
                  ? calculateAge(widget.userDetails["date"]).toString()
                  : "No age",
              "Marital Status": widget.userDetails["maritalStatus"] ?? "Unmarried",
              "Hobbies":widget.userDetails['hobby'] is String ? (jsonDecode(widget.userDetails['hobby']) as List).join(', ')
                : (widget.userDetails['hobby'] as List).join(', ')
            }),
            buildSection("Religious Background", {
              "Country": widget.userDetails["country"] ?? "India",
              "State": widget.userDetails["state"] ?? "Gujarat",
              "City":widget.userDetails['city'] ?? 'N/A',
              'Address':widget.userDetails['address'].toString().length <15  ? widget.userDetails['address'] :
              widget.userDetails['address'].toString().substring(15)+'...',
              "Religion": widget.userDetails["religion"] ?? "Hindu",
              "Caste": widget.userDetails["caste"] ?? "Caste",
              "Sub Caste": widget.userDetails["subCaste"] ?? "sub caste",
            }),
            buildSection("Professional Details", {
              "Education": widget.userDetails["education"] ?? "M.tech",
              "Occupation": widget.userDetails["occupation"] ?? "Engineer",
            }),

            buildSection("Contact Details", {
              "Email": widget.userDetails["email"] ?? "N/A",
              "Phone": widget.userDetails["phone"] ?? "N/A",
              'password':widget.userDetails['password'] ??'N/A'
            }),

            SizedBox(height: 16),

            Center(
              child: ElevatedButton(
                onPressed: () {

                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text("Edit", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
