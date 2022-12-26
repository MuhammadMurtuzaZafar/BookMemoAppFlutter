import 'package:flutter_repository_pattern/db/database_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/app_constant.dart';
import '../models/book.dart';

class DatabaseController{

  final dbClient=DatabaseProvider.dbProvider;

  Future<int> createBookRow(Book b) async{
    final db=await dbClient.db;
    var result=await db.insert(AppConstant.tableName, b.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List<Book>> getAllBooks({List<String>? columns})async{
    final db=await dbClient.db;
    var result=await db.query(AppConstant.tableName,columns:columns ,orderBy: "id DESC");
    List<Book> books=result.isNotEmpty ?result.map((e) => Book.fromMap(e)).toList():[];
    return books;
  }

  Future<List<Book>> searchBook(int id)async{
    final db=await dbClient.db;
    var result=await db.query(AppConstant.tableName,where: "id=?",whereArgs: [id] );
    List<Book> books=result.isNotEmpty ?result.map((e) => Book.fromMap(e)).toList():[];
    return books;
  }

  Future<int> updateBook(Book b)async{
    final db=await dbClient.db;
    var result=await db.update(AppConstant.tableName, b.toMap(),where: "id=?",whereArgs: [b.id]);
    return result;
  }
  Future<int> deleteBook(int id)async{
    final db=await dbClient.db;
    var result=await db.delete(AppConstant.tableName,where: "id=?",whereArgs: [id]);
    return result;
  }
}