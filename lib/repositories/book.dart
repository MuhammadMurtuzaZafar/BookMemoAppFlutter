import 'package:flutter_repository_pattern/db/virtual_db.dart';
import 'package:flutter_repository_pattern/models/book.dart';
import 'package:flutter_repository_pattern/repositories/book_interface.dart';

class BookRepositories extends IBookRepositories{

  final VirtualDB _db;
  BookRepositories(this._db);

  @override
  Future<void> delete(int id) async{

    await _db.removed(id);
  }

  @override
  Future<List<Book>> getAll() async{

    var items=await _db.list();
    return items.map((e) => Book.fromMap(e)).toList();
  }

  @override
  Future<Book?> getOne(int id) async{

    dynamic item=await _db.findOne(id);

    return item!=null?Book.fromMap(item):null;
  }

  @override
  Future<void> insert(Book book) async{
    await _db.insert(book.toMap());

  }

  @override
  Future<void> update(Book book) async{
    await _db.update(book.toMap());
  }
}