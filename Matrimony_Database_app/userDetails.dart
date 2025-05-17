// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:matriomony/user.dart';
//
// class Userdetails extends StatefulWidget {
//   Map<String , dynamic> userDetail={};
//
//   Userdetails({super.key,required this.userDetail});
//
//   @override
//   State<Userdetails> createState() => _UserdetailsState();
// }
//
// class _UserdetailsState extends State<Userdetails> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Center(
//           child: const Text(
//             'User Details',
//             style: TextStyle(color: Colors.black, fontSize: 25),
//           ),
//         ),
//         backgroundColor: Colors.pink.shade100,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundColor: Colors.pink.shade200,
//                     child: Icon(Icons.person, size: 40, color: Colors.white),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "User Name",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink.shade700),
//                   ),
//                   Text("User ID", style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//
//                 children: widget.userDetail.entries.map((entry) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 6),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           (entry.key + ' :      '+ entry.value.toString()),
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink.shade700),
//                         ),
//                         // Text(
//                         //   entry.value.toString(),
//                         //   style: TextStyle(fontSize: 16, color: Colors.black87),
//                         // ),
//                         Divider(color: Colors.pink.shade100),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.pink.shade300,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 ),
//                 child: Text("Edit", style: TextStyle(fontSize: 16, color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matriomony/addUser.dart';
import 'package:matriomony/string_const.dart';
import 'package:matriomony/user.dart';

class Userdetails extends StatefulWidget {
  Map<String, dynamic> userDetails;

  Userdetails({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  var color;
  @override
  void initState(){
    super.initState();
    widget.userDetails['GENDER']=='Female' ? color=Colors.deepPurple.shade200: color=Colors.blueGrey.shade300;
  }

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
                    backgroundImage: widget.userDetails['GENDER']=='Female' ? AssetImage('assets/images/girl1.png') : AssetImage('assets/images/boy.png')
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.userDetails['NAME'] ?? "User Name",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "User ID: ${widget.userDetails['UserId'] ?? "N/A"}",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Sections
            buildSection("About",{
              "Gender": widget.userDetails['GENDER'] ?? "N/A",
              "Date of Birth": widget.userDetails["DATE"] ?? "N/A",
              "Marital Status": widget.userDetails["maritalStatus"] ?? "Unmarried",
            }),
            buildSection("Religious Background", {
              "Country": widget.userDetails["country"] ?? "India",
              "State": widget.userDetails["state"] ?? "Gujarat",
              "City":widget.userDetails['CITY'] ?? 'N/A',
              'Address':widget.userDetails['ADDRESS'].toString().length < 15 ? widget.userDetails['ADDRESS'] :
              widget.userDetails['ADDRESS'].toString().substring(15)+'...',
              "Religion": widget.userDetails["religion"] ?? "Hindu",
              "Caste": widget.userDetails["caste"] ?? "Caste",
              "Sub Caste": widget.userDetails["subCaste"] ?? "sub caste",
            }),
            buildSection("Professional Details", {
              "Education": widget.userDetails["education"] ?? "M.tech",
              "Occupation": widget.userDetails["occupation"] ?? "Engineer",
            }),

            buildSection("Contact Details", {
              "Email": widget.userDetails["EMAIL"] ?? "N/A",
              "Phone": widget.userDetails["PHONE"] ?? "N/A",
              'password':widget.userDetails['PASSWORD'] ??'N/A'
            }),

            SizedBox(height: 16),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         AddUser(
                  //             userDetails:),
                  //   ),
                  // ).then((updatedUser) {
                  //   if (updatedUser != null) {
                  //     setState(() {
                  //       User.userList[index] = updatedUser;
                  //     });
                  //   }
                  //   Navigator.of(context)
                  //       .pop();
                  // });
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
