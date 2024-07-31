import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart'; // Required for joining paths

class SQLHelper {
  // Method to create tables in the database
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE book (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        bookName TEXT NOT NULL,
        authorName TEXT,
        pageNumber INTEGER,
        datePublished TEXT,
        cityPublish TEXT
      )
    """);
  }

  // Method to initialize and open the database
  static Future<sql.Database> db() async {
    // Define the path to the database file
    String path = join(await sql.getDatabasesPath(), 'database_name.db');

    // Open the database and set up the tables if it is created for the first time
    return sql.openDatabase(
      path,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Method to insert data into the book table
  static Future<int> createData(String bookName, String? authorName, int pageNumber, String? datePublished, String? cityPublish, String? s) async {
    final db = await SQLHelper.db();

    final data = {
      'bookName': bookName,
      'authorName': authorName,
      'pageNumber': pageNumber,
      'datePublished': DateTime.now().toString(), // Store current date and time
      'cityPublish': cityPublish,
    };

    final id = await db.insert(
      'book', // Table name should be 'book'
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace, // Use ConflictAlgorithm.replace or another appropriate algorithm
    );
    return id;
  }

  // Method to get all data from the book table
  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await SQLHelper.db();
    return db.query('book', orderBy: 'id'); // Correct table name 'book'
  }

  // Method to update a specific book entry by its id
  static Future<int> updateData(int id, String bookName, String? authorName, int pageNumber, String? cityPublish, String? s) async {
    final db = await SQLHelper.db();

    final data = {
      'bookName': bookName,
      'authorName': authorName,
      'pageNumber': pageNumber,
      'datePublished': DateTime.now().toString(), // Store current date and time
      'cityPublish': cityPublish,
    };

    final result = await db.update(
      'book', // Table name should be 'book'
      data,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }

  // Method to delete a specific book entry by its id
  static Future<int> deleteData(int id) async {
    final db = await SQLHelper.db();

    try {
      final result = await db.delete(
        'book', // Table name should be 'book'
        where: 'id = ?',
        whereArgs: [id],
      );
      return result;
    } catch (e) {
      print('Error deleting data: $e');
      return -1; // Return -1 to indicate that an error occurred
    }
  }
}
