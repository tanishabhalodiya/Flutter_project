  import 'dart:convert';


  import 'package:sqflite/sqflite.dart';

import 'database.dart';

  class User {
    static List<Map<String, dynamic>> userList = [];
    static int age=0;

    //insert user in TABLE
    Future<void> addUser({required name,required address,required email,required phone,
      required date,required gender,required city,required hobby,required pass,required conpass,fav})
    async{
      Database db=await MatrimonialDatabase().initDatabase();
      Map<String , dynamic> map={};

      map[MatrimonialDatabase.NAME] =name;
      map[MatrimonialDatabase.ADDRESS]=address;
      map[MatrimonialDatabase.EMAIL]=email;
      map[MatrimonialDatabase.PHONE]=phone;
      map[MatrimonialDatabase.DATE]=date;
      map[MatrimonialDatabase.GENDER]=gender;
      map[MatrimonialDatabase.CITY]=city;
      map[MatrimonialDatabase.HOBBY]=jsonEncode(hobby);
      map[MatrimonialDatabase.PASSWORD]=pass;
      map[MatrimonialDatabase.CONPASS]=conpass;
      map[MatrimonialDatabase.FAV]=fav ?? 0;


      // print("::::::::::::::::$map::::::::::::::::::");

      int number=await db.insert(MatrimonialDatabase.TBL_NAME, map);
      if(number==-1){
        print('################Insertion is failed');
      }
      else{
        print('########################################Data insedted successfully with id : $number');
        userList.add(map);
        print("+++++++++++++++++++++++I am Added++++++++++++++++++++++++++++");
        userList=await getUserList();
      }
    }


    // get print details of all User
    Future<List<Map<String, dynamic>>> getUserList() async {
      Database db = await MatrimonialDatabase().initDatabase();
      userList.clear();
      userList.addAll(
          await db.rawQuery('SELECT * FROM ${MatrimonialDatabase.TBL_NAME}')
      );

      return userList;
    }

    //delete User
    Future<int> deleteUser(int id) async{
      Database db=await MatrimonialDatabase().initDatabase();
      return await db.delete('Users', where: "UserId = ?", whereArgs: [id]);
    }

    Future<int> updateUser(int? id, Map<String, dynamic> user) async {
      Database db = await MatrimonialDatabase().initDatabase();

      //remove id from user map because it gives error in updating
      user.remove(MatrimonialDatabase.USER_ID);
      print("$id frommmmmmmmmmmmmmmmmmmmmmmmmm $user");
      int number = await db.update(
        MatrimonialDatabase.TBL_NAME,
        user,
        where: "${MatrimonialDatabase.USER_ID} = ?",
        whereArgs: [id],
      );
      // User.userList=await getUserList();
      // User.userList = List.from(User.userList); // Change reference to trigger rebuild
      return number;
    }
    static Future<void> refreshUserList() async {
      userList = List.from(await User().getUserList());
    }

  }