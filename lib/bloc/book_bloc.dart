import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_repository_pattern/models/book.dart';
import 'package:meta/meta.dart';

import '../db/virtual_db.dart';
import '../repositories/book.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {

  final BookRepositories _bookRepo = BookRepositories();
  List<Book> bookList=[];

  BookBloc() : super(BookInitial()) {
    on<FormBookChangeEvent>((event, emit) {
      if(event.book.isEmpty )
      {
      return  emit(BookNameErrorState("Please Enter a Book Name"));
      }
      else{
        return emit(BookNameValidState());
      }


    });

    on<FormYearChangeEvent>((event, emit) {
      if(event.year.isEmpty)
      {
        return emit(BookYearErrorState("Please Enter a Year Name"));
      } else{
        return emit(BookYearValidState());
      }


    });

    on<FormSubmitEvent>((event, emit)  {

      if(event.book.isEmpty){
        return emit(BookNameErrorState("Please Enter a Book Name"));
      }
      else  if(event.year.isEmpty)
      {
        return emit(BookYearErrorState("Please Enter a Year Name"));
      }
      else  if(!_isNumeric(event.year))
      {
        return emit(BookYearErrorState("Please Enter a Year Name"));
      }
      else{
        _bookRepo.insert(Book(0, event.book, int.parse(event.year)));
        add(FetchBookEvent());
          return  emit(BookFormValidState());
      }

    });
    on<FetchBookEvent>((event, emit) async{
      emit(BookLoadingState(true));
        bookList=await _bookRepo.getAll();
        emit(BookLoadingState(false));
    });

    on<DeleteBookEvent>((event, emit) {
      _bookRepo.delete(event.id);
      add(FetchBookEvent());
    });

    on<EditBookEvent>((event, emit) {
      emit(BookEditState(event.book));
    });

    on<EditSubmitEvent>((event, emit) {
      if(event.book.title.isEmpty){
        return emit(BookNameErrorState("Please Enter a Book Name"));
      }
      else  if(event.book.year.toString().isEmpty)
      {
        return emit(BookYearErrorState("Please Enter a Year Name"));
      }
      else  if(!_isNumeric(event.book.year.toString()))
      {
        return emit(BookYearErrorState("Please Enter a Year Name"));
      }
      else{
        _bookRepo.update(event.book);
        add(FetchBookEvent());
        return  emit(BookFormValidState());
      }

    });
    add(FetchBookEvent());


  }
  bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
