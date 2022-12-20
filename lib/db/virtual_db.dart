import 'dart:math';

class VirtualDB{

  final List<Map<String,dynamic>> _items=[];
  static final VirtualDB _db=VirtualDB._privateConstructor();

  VirtualDB._privateConstructor();

  factory VirtualDB()
  {
    return _db;
  }


  Future<void> insert(Map<String,dynamic> item) async {
    item['id']=Random().nextInt(100);
    _items.add(item);
  }

  Future<void> removed(int id)async{
    _items.removeWhere((element) => element['id']==id);
  }
  Future<void> update(Map<String,dynamic> item)async{
   int i= _items.indexWhere((element) => element['id']==item['id']);


   _items[i]=item;
  }
  Future<List<Map<String,dynamic>>> list()async{
    await Future.delayed(const Duration(milliseconds: 800));
    return _items;
  }
  Future<Map<String,dynamic>> findOne(int id)async {
    return _items.firstWhere((element) => element['id']==id);
  }

}