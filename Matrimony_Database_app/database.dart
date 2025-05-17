import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MatrimonialDatabase{

  //region DB CONSTANT VARIABLE
  static const String TBL_NAME ='Users';
  static const String USER_ID='UserId';
  static const String NAME = 'NAME';
  static const String ADDRESS = 'ADDRESS';
  static const String EMAIL = 'EMAIL';
  static const String PHONE='PHONE';
  static const String DATE='DATE';
  static const String GENDER='GENDER';
  static const String CITY='CITY';
  static const String HOBBY='HOBBY';
  static const String PASSWORD='PASSWORD';
  static const String CONPASS='CONPASS';
  static const String FAV='FAV';
  //endregion


  int DB_VERSION =7;

  //region INIT DATABASE METHOD
  //database ne initialize krva mate ni method
  Future<Database> initDatabase() async {
    Database db = await openDatabase(
      //
      '${await getDatabasesPath()}/MatrimonyApp.db',
      onCreate: (db, version) {
        db.execute(
          '''CREATE TABLE $TBL_NAME
              ($USER_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              $NAME TEXT NOT NULL,
              $ADDRESS TEXT ,
              $EMAIL TEXT,
              $PHONE INTEGER,
              $CITY TEXT
              $DATE TEXT,
              $GENDER TEXT,
              $HOBBY TEXT,
              $PASSWORD TEXT,
              $CONPASS TEXT,
              $FAV INTEGER
              );''',
        );
      },

        // onUpgrade: (db, oldVersion, newVersion) async {
        //   try {
        //     if (oldVersion < 7) {
        //       await db.execute("ALTER TABLE $TBL_NAME ADD COLUMN $DATE TEXT");
        //       await db.execute("ALTER TABLE $TBL_NAME ADD COLUMN $GENDER TEXT");
        //       await db.execute("ALTER TABLE $TBL_NAME ADD COLUMN $HOBBY TEXT");
        //       await db.execute("ALTER TABLE $TBL_NAME ADD COLUMN $PASSWORD TEXT");
        //       await db.execute("ALTER TABLE $TBL_NAME ADD COLUMN $CONPASS TEXT");
        //       await db.execute("ALTER TABLE $TBL_NAME ADD COLUMN $FAV INTEGER");
        //     }
        //   }
        //   catch (e) {
        //     print("Database Upgrade Error: $e");
        //   }
        // },
      version: DB_VERSION,
    );
    List<Map<String, dynamic>> result = await db.rawQuery('PRAGMA table_info($TBL_NAME)');
    print(result);
    return db;
  }

  //endregion
}
