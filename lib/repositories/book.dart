import 'package:flutter_repository_pattern/db/virtual_db.dart';
import 'package:flutter_repository_pattern/models/book.dart';
import 'package:flutter_repository_pattern/repositories/book_interface.dart';

import '../db/database_controller.dart';

class BookRepositories extends IBookRepositories{

  final DatabaseController dbController = DatabaseController();

  @override
  Future<void> delete(int id) async{

    await dbController.deleteBook(id);
  }

  @override
  Future<List<Book>> getAll() async{

    var items=await dbController.getAllBooks();
    return items;
  }

  @override
  Future<Book?> getOne(int id) async{
   dynamic item=await dbController.searchBook(id);

    return item!=null?Book.fromMap(item):null;
  }

  @override
  Future<void> insert(Book book) async{
    await dbController.createBookRow(book);

  }

  @override
  Future<void> update(Book book) async{
    await dbController.updateBook(book);
  }
}