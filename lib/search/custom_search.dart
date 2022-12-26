

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_repository_pattern/bloc/book_bloc.dart';
import 'package:flutter_repository_pattern/models/book.dart';

class CustomSearch extends SearchDelegate{



  List<Book> bookList;


  CustomSearch(this.bookList);

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(onPressed: (){
        query='';

      }, icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(onPressed: (){
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {

    final suggestList=query.isEmpty?[]:bookList.where((element) => element.title.contains(query)).toList();
    return ListView.builder(
      itemCount: suggestList.length,
      itemBuilder: (context, index) {
        return myCard(bookList[index],context);
      },);
  }


  @override
  Widget buildSuggestions(BuildContext context) {


    final suggestList=query.isEmpty?bookList:bookList.where((element) => element.title.contains(query)).toList();
    return ListView.builder(
        itemCount: suggestList.length,
        itemBuilder: (context, index) {
          return myCard(bookList[index],context);
        },);
  }

  Widget myCard(Book b,context) {
    return Card(
      elevation: 1.5,
      color:  const Color(0xFF4B4848),
      child: ListTile(
        onTap: ()
        {
          query=b.title;
        },
        title: Text(b.title),
        subtitle: Text(b.year.toString()),
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    assert(theme != null);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        brightness: colorScheme.brightness,
        backgroundColor:Colors.black,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        textTheme: theme.textTheme.copyWith().apply(bodyColor: Colors.black),
      ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white, //<-- SEE HERE
          displayColor: Colors.white, //<-- SEE HERE
        ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

}