

import 'package:flutter/material.dart';
var suggestion=["Qadeer","Tipu qadeer","Bekar Wadeer"];

class CustomSearch extends SearchDelegate{

  List<String> allNames = ["ahmed", "ali", "john", "user"];


  List<String> searchResult=[];
  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(onPressed: (){
        query='';

      }, icon: const Icon(Icons.search))
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

    return Container();

  }


  @override
  Widget buildSuggestions(BuildContext context) {


    final suggestList=query.isEmpty?suggestion:allNames.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              if (query.isEmpty) {
                query = suggestion[index];
              }
            },
            title: Text(suggestList[index]),
          );
        },);
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