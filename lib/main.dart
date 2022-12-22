import 'package:flutter/material.dart';
import 'package:flutter_repository_pattern/bloc/book_bloc.dart';
import 'package:flutter_repository_pattern/view/book_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

var bg_color = Color(0xff3f3f44);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          dialogTheme: const DialogTheme(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.2, color: Colors.white),
              )),
          scaffoldBackgroundColor: bg_color,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
          primarySwatch: Colors.blue,
          primaryColor: Colors.black38,
          buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.dark(background: bg_color)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.black),
          inputDecorationTheme: InputDecorationTheme(
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: bg_color)),
              enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: bg_color)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              hintStyle: TextStyle(color: Colors.grey)),
          cardColor: bg_color,
          backgroundColor: bg_color,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white, //<-- SEE HERE
                displayColor: Colors.white, //<-- SEE HERE
              )),
      home: BlocProvider(
        create: (context) => BookBloc(),
        child: BookList(),
      ),
    );
  }
}
