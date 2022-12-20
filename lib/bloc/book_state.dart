part of 'book_bloc.dart';

@immutable
abstract class BookState {}

class BookInitial extends BookState {}

class BookLoadingState extends BookState {
  bool load;

  BookLoadingState(this.load);
}

class BookNameValidState extends BookState{}
class BookYearValidState extends BookState{}

class BookFormValidState extends BookState{}

class BookNameErrorState extends BookState{
  String error;
  BookNameErrorState(this.error);
}
class BookYearErrorState extends BookState{
  String error;
  BookYearErrorState(this.error);
}

