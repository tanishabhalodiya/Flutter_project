import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matriomony/user.dart';
import '../string_const.dart';

class AddUser extends StatefulWidget {
  Map<String, dynamic>? userDetails = {};
  int? index;

  AddUser({super.key, this.userDetails, this.index});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController rpwdController = TextEditingController();

  String buttonType = '';
  List<String> cities = ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'];
  List<String> gender = ['Female', 'Male'];
  List<String> hobbies = ['Reading', 'Music', 'Dance', 'Time-Pass'];
  List<String> selectedHobby = [];

  String dob = 'Select date of birth';
  DateTime? date = DateTime.now();

  String? selectedCity = 'Rajkot';
  String? selectedGender = 'Female';
  bool? isCheckedRead = false;
  bool? isCheckedDance = false;
  bool? isCheckedMusic = false;
  bool? isCheckedTimePass = false;
  bool isFavourite = false;
  bool isPasswordVisible = false;
  bool isRePasswordVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.userDetails != null) {
      // filling form from data
      nameController.text = widget.userDetails?['NAME'] ?? 'Unknown';
      emailController.text = widget.userDetails?['EMAIL'] ?? 'no email';
      addressController.text = widget.userDetails?['ADDRESS'] ?? 'no address';
      phoneController.text = widget.userDetails?['PHONE'].toString() ?? 'no phone';
      dobController.text = widget.userDetails?['DATE'] ?? 'no date';
      selectedGender = widget.userDetails?['GENDER'] ?? 'Female';
      selectedCity = widget.userDetails?['CITY'] ?? 'Rajkot';
      pwdController.text = widget.userDetails?['PASSWORD'] ?? 'No password';
      rpwdController.text = widget.userDetails?['CONPASS'] ?? 'No password';
      // isFavourite = widget.userDetails?['FAV'] ?? false;
      selectedHobby = List<String>.from(widget.userDetails?['HOBBY'] ?? []);
    }
    buttonType = widget.userDetails == null ? 'Add user' : 'Update user';
  }

  @override
  Widget build(BuildContext context) {
    User user = User();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            buttonType,
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade100, Colors.blueGrey.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            // color: Colors.blueGrey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.drive_file_rename_outline),
                          labelText: 'Name',
                          hintText: 'Enter your full name',
                          // filled: true,  // Enables background fill
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter name please';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]{3,50}$').hasMatch(value!)) {
                            return 'Enter Valid full name';
                          }
                        },
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'[0-9]'))
                        ],
                        autofocus: true,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: addressController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city_sharp),
                          labelText: 'Address',
                          hintText: 'Enter your full address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter address please';
                          }
                          if (value.length < 5) {
                            return 'Enter a valid address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          labelText: 'Email',
                          hintText: 'Enter your email address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter email please';
                          }
                          if (!RegExp(
                                  r'^[a-zA-Z0-9._%+]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                              .hasMatch(value!)) {
                            return 'Enter a valid email address';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'[A-Z]'))
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.phone),
                          labelText: 'Phone',
                          hintText: 'Enter your phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter phone number please';
                          }
                          if (!RegExp(r'^\+?[0-9]{10}$').hasMatch(value)) {
                            return 'Enter a valid phone number';
                          }
                        },
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: dobController,
                        decoration: InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintText: 'Select your date of birth',
                            prefixIcon: IconButton(
                              onPressed: () async {
                                DateTime currentDate = DateTime.now();
                                DateTime firstDate = DateTime(
                                    currentDate.year - 80,
                                    currentDate.month,
                                    currentDate.day);
                                DateTime lastDate = DateTime(
                                    gender == 'Female'
                                        ? currentDate.year - 18
                                        : currentDate.year - 21,
                                    currentDate.month,
                                    currentDate.day);
                                DateTime initialDate =
                                    (currentDate.isAfter(lastDate))
                                        ? lastDate
                                        : currentDate;

                                DateTime? datePicker = await showDatePicker(
                                  context: context,
                                  initialDate: initialDate,
                                  firstDate: firstDate,
                                  lastDate: lastDate,
                                );
                                if (datePicker != null) {
                                  // print("${datePicker.day}-${datePicker.month}-${datePicker.year}");
                                  setState(() {
                                    dob = DateFormat('dd-MM-yyyy')
                                        .format(datePicker);
                                    dobController.text = dob;
                                  });
                                }
                              },
                              icon: Icon(CupertinoIcons.calendar),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Gender : ',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Radio(
                                        value: 'Female',
                                        groupValue: selectedGender,
                                        onChanged: (value) => setState(() {
                                              selectedGender = value.toString();
                                            })),
                                    Text("Female"),
                                    Radio(
                                        value: 'Male',
                                        groupValue: selectedGender,
                                        onChanged: (value) => setState(() {
                                              selectedGender = value.toString();
                                            })),
                                    Text("Male")
                                  ],
                                ))
                            // ))
                          ],
                        ),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('City : ',
                                        style: TextStyle(fontSize: 17)),
                                  )),
                              Expanded(
                                flex: 8,
                                child: Center(
                                  child: DropdownButton(
                                    value: selectedCity,
                                    items: cities.map((city) {
                                      return DropdownMenuItem(
                                        value: city,
                                        child: Text(city.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCity = value;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('Hobbies:',style: TextStyle(fontSize: 17)),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Wrap(
                                  spacing: 10,
                                  children: hobbies.map((hobby) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Checkbox(
                                          value: selectedHobby.contains(hobby),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value == true) {
                                                selectedHobby.add(hobby);
                                              } else {
                                                selectedHobby.remove(hobby);
                                              }
                                            });
                                          },
                                        ),
                                        Text(hobby),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: !isPasswordVisible,
                        controller: pwdController,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            prefixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                icon: Icon(isPasswordVisible
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: !isRePasswordVisible,
                        controller: rpwdController,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Enter your confirm password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            prefixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isRePasswordVisible = !isRePasswordVisible;
                                  });
                                },
                                icon: Icon(isRePasswordVisible
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != pwdController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> new_user = {};
                            new_user[NAME] = nameController.text.isEmpty
                                ? 'NONE'
                                : nameController.text;
                            new_user[ADDRESS] = addressController.text.isEmpty
                                ? 'None'
                                : addressController.text;
                            new_user[EMAIL] = emailController.text.isEmpty
                                ? 'No email'
                                : emailController.text;
                            new_user[PHONE] = phoneController.text.isEmpty
                                ? 'N/A'
                                : phoneController.text;
                            new_user[DATE] = dobController.text.isEmpty
                                ? 'no date'
                                : dobController.text;
                            new_user[PWD] = pwdController.text.isEmpty
                                ? 'no password'
                                : pwdController.text;
                            new_user[CONPASS] = rpwdController.text.isEmpty
                                ? 'no repeat password'
                                : rpwdController.text;
                            new_user[GENDER] = selectedGender;
                            new_user[CITY] = selectedCity;
                            new_user[HOBBY] = selectedHobby;


                            print(
                                'SELECTED HOBBY ::::::::::::::::::: $selectedHobby');
                            new_user[FAV] = (isFavourite ?? false) ? 1 : 0;

                            int? id = widget.userDetails?['UserId'];
                            print('USER ID IS :::::::::::::::::::::::::: $id');

                            if (id == null) {
                              print('MAP TO INSERT: $new_user');
                              await user.addUser(
                                name: new_user[NAME],
                                address: new_user[ADDRESS],
                                phone: new_user[PHONE],
                                email: new_user[EMAIL],
                                city: new_user[CITY],
                                date: new_user[DATE],
                                gender: new_user[GENDER],
                                hobby: new_user[HOBBY],
                                pass: new_user[PWD],
                                conpass: new_user[CONPASS],
                                fav: (isFavourite ?? false) ? 1 : 0,
                              );

                              print(
                                  "New user added!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                            } else {
                              // new_user.remove(FAV);
                              // new_user[FAV] = (isFavourite ?? false) ? 1 : 0;
                              // new_user[HOBBY] = selectedHobby is String ? [selectedHobby] : selectedHobby;
                              // new_user[HOBBY] = jsonEncode(new_user[HOBBY]);
                              await user.updateUser(id, new_user);
                              print(
                                  "User updated successfully!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                            }

                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          buttonType,
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class AddUser extends StatefulWidget {
//   Map<String, dynamic>? userDetails = {};
//   int? index;
//
//   AddUser({super.key, this.userDetails, this.index});
//
//   @override
//   State<AddUser> createState() => _AddUserState();
// }
//
// class _AddUserState extends State<AddUser> {
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//
//   List<String> genderOptions = ['Female', 'Male', 'Other'];
//   String? selectedGender = 'Female';
//
//   String dob = 'Select date of birth';
//   DateTime? date = DateTime.now();
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.userDetails != null) {
//       nameController.text = widget.userDetails?['NAME'] ?? '';
//       emailController.text = widget.userDetails?['EMAIL'] ?? '';
//       addressController.text = widget.userDetails?['ADDRESS'] ?? '';
//       phoneController.text = widget.userDetails?['PHONE'] ?? '';
//       dobController.text = widget.userDetails?['DATE'] ?? '';
//       selectedGender = widget.userDetails?['GENDER'] ?? 'Female';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.userDetails == null ? 'Add User' : 'Update User',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.purple.shade700,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           // Background Gradient with Circular Decorations
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.deepPurple.shade100, Colors.blueGrey.shade100],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           Positioned(
//             top: -80,
//             right: -50,
//             child: Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.purple.shade200.withOpacity(0.5),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -100,
//             left: -80,
//             child: Container(
//               width: 250,
//               height: 250,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.blueGrey.shade100.withOpacity(0.4),
//               ),
//             ),
//           ),
//           // Form with Glassmorphism Effect
//           Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(30.0),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                     child: Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(30.0),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.3),
//                         ),
//                       ),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TextFormField(
//                               controller: nameController,
//                               decoration: InputDecoration(
//                                 labelText: 'Name',
//                                 hintText: 'Enter your full name',
//                                 prefixIcon: Icon(CupertinoIcons.person),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Enter name please';
//                                 }
//                                 if (!RegExp(r'^[a-zA-Z\s]{3,50}$')
//                                     .hasMatch(value)) {
//                                   return 'Enter a valid full name';
//                                 }
//                                 return null;
//                               },
//                               keyboardType: TextInputType.name,
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               controller: emailController,
//                               decoration: InputDecoration(
//                                 labelText: 'Email',
//                                 hintText: 'Enter your email address',
//                                 prefixIcon: Icon(CupertinoIcons.mail),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Enter email please';
//                                 }
//                                 if (!RegExp(
//                                     r'^[a-zA-Z0-9._%+]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
//                                     .hasMatch(value)) {
//                                   return 'Enter a valid email address';
//                                 }
//                                 return null;
//                               },
//                               keyboardType: TextInputType.emailAddress,
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               controller: phoneController,
//                               decoration: InputDecoration(
//                                 labelText: 'Phone',
//                                 hintText: 'Enter your phone number',
//                                 prefixIcon: Icon(CupertinoIcons.phone),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Enter phone number please';
//                                 }
//                                 if (!RegExp(r'^\+?[0-9]{10}$')
//                                     .hasMatch(value)) {
//                                   return 'Enter a valid phone number';
//                                 }
//                                 return null;
//                               },
//                               keyboardType: TextInputType.phone,
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               controller: dobController,
//                               readOnly: true,
//                               decoration: InputDecoration(
//                                 labelText: 'Date of Birth',
//                                 hintText: 'Select your date of birth',
//                                 prefixIcon: Icon(CupertinoIcons.calendar),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                 ),
//                               ),
//                               onTap: () async {
//                                 DateTime? datePicker = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(1950),
//                                   lastDate: DateTime.now(),
//                                 );
//                                 if (datePicker != null) {
//                                   setState(() {
//                                     dob = DateFormat('dd-MM-yyyy')
//                                         .format(datePicker);
//                                     dobController.text = dob;
//                                   });
//                                 }
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 if (_formKey.currentState!.validate()) {
//                                   // Form is valid, do something
//                                 }
//                               },
//                               icon: Icon(CupertinoIcons.checkmark_alt_circle),
//                               label: Text("Submit"),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.deepPurple.shade400,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
