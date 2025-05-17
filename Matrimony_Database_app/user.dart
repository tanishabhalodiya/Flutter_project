  import 'dart:convert';

  import 'package:matriomony/database.dart';
  import 'package:matriomony/string_const.dart';
  import 'package:sqflite/sqflite.dart';

  class User {
    static List<Map<String, dynamic>> userList = [

      {
        'name': 'Tanisha',
        'email': 'abc@gmail.com',
        'phone': '9404093367',
        'date': '10-7-2005',
        'gender':'Female'
      },
      {
        'name': 'Nihar',
        'email': 'abc@gmail.com',
        'phone': '1234567890',
        'date': '10-8-2010',
        'gender':'Male'
      },
      {
        'name': 'Meera',
        'email': 'abc@gmail.com',
        'phone': '9404093367',
        'date': '10-7-2005',
        'gender':'Female'
      }
    ];

    //insert user in TABLE
    Future<void> addUser({required name,required address,required email,required phone,
      required date,required gender,required city,required List<String> hobby,required pass,required conpass,fav})
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
      map[MatrimonialDatabase.FAV]=0;

      int number=await db.insert(MatrimonialDatabase.TBL_NAME, map);
      if(number==-1){
        print('################Insertion is failed');
      }
      else{
        print('########################################Data insedted successfully with id : $number');
        // userList.add(map);
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
      return await db.update(
        MatrimonialDatabase.TBL_NAME,
        user,
        where: "${MatrimonialDatabase.USER_ID} = ?",
        whereArgs: [id],
      );
    }
  }