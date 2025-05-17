import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:restapi_matriomony/apiService.dart';
import 'package:restapi_matriomony/user.dart';
import 'package:restapi_matriomony/userList.dart';


class AddUser extends StatefulWidget {
  Map<String, dynamic>? userDetails = {};
  int? index;

  AddUser({super.key, this.userDetails, this.index});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  ApiService apiUser=ApiService();
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

  String? dob;
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
      // Filling form with existing user data
      nameController.text = widget.userDetails?['name'] ?? '';
      emailController.text = widget.userDetails?['email'] ?? '';
      addressController.text = widget.userDetails?['address'] ?? '';
      phoneController.text = widget.userDetails?['phone']?.toString() ?? 'no phone';
      dobController.text = widget.userDetails?['date'] ?? '';
      selectedGender = widget.userDetails?['gender'] ?? 'Female';
      selectedCity = widget.userDetails?['city'] ?? 'Rajkot';
      pwdController.text = widget.userDetails?['password'] ?? '';
      rpwdController.text = widget.userDetails?['conpass'] ?? '';
      isFavourite = widget.userDetails?['fav'];
      print('FAVVVVVVVVVVVVVVVVVVVVVVV : ${widget.userDetails?['fav']}');


        if (widget.userDetails?['hobby'] is String) {
          selectedHobby = List<String>.from(jsonDecode(widget.userDetails!['hobby']));
        } else if (widget.userDetails?['hobby'] is List) {
          selectedHobby = List<String>.from(widget.userDetails!['hobby']);
        } else {
          selectedHobby = [];
        }
    }
    buttonType = widget.userDetails == null ? 'Add user' : 'Update user';
  }


  @override
  Widget build(BuildContext context) {
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
                        textCapitalization: TextCapitalization.words,
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
                                    dob = DateFormat('dd-MM-yyyy').format(datePicker);
                                    dobController.text = dob!;
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
                                  child: Text('City:', style: TextStyle(fontSize: 17)),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: selectedCity,
                                    items: cities.map((String city) {
                                      return DropdownMenuItem<String>(
                                        value: city,
                                        child: Text(city),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCity = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),                        ],
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
                            Map<String, dynamic> newUser  = {
                              'id': widget.userDetails?['id'],
                              'name': nameController.text,
                              'address': addressController.text,
                              'email': emailController.text,
                              'phone': phoneController.text,
                              'date': dobController.text,
                              'password': pwdController.text,
                              'conpass': rpwdController.text,
                              'gender': selectedGender,
                              'city': selectedCity,
                              'hobby': jsonEncode(selectedHobby),
                              'fav': isFavourite ? true : false,
                            };
                            print('::::::::::::NEW MAP :::::::::::::::::: $newUser');

                            if (widget.userDetails != null) {
                              // If userDetails is not null,aapde update krsu
                              String userId = widget.userDetails!['id']; //id update krva matenu
                              await apiUser.updateData(userId, newUser );
                            } else {
                              // If userDetails is null, aapde add krsu
                              await apiUser.addUser(newUser );
                            }
                            // navigate back to the user list direct
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => UserList()),
                            );
                          }
                        },
                        child: Text(buttonType),
                      ),
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
