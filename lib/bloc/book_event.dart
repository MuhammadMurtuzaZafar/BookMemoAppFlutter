part of 'book_bloc.dart';

abstract class BookEvent {}

class FormBookChangeEvent extends BookEvent{
  String book;
  FormBookChangeEvent(this.book);
}
class FormYearChangeEvent extends BookEvent{
  String year;
  FormYearChangeEvent(this.year);
}
class FormSubmitEvent extends BookEvent{
  String book;
  String year;

  FormSubmitEvent(this.book, this.year);
}
class FetchBookEvent extends BookEvent{}