import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_bloc.dart';
import '../models/book.dart';

class BookList extends StatelessWidget {

  final TextEditingController _bookNameCon = TextEditingController();
  final TextEditingController _bookYearCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BookBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
      ),
      body: BlocConsumer<BookBloc, BookState>(
        bloc: bloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          return state is BookLoadingState && state.load?const Center(child: CupertinoActivityIndicator(color: Colors.white,)): ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: bloc.bookList.length,
            itemBuilder: (context, index) {
              return myCard(bloc.bookList[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlert(context, bloc);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget myCard(Book b) {
    return Card(
      elevation: 1.5,
      color:  Color(0xFF4B4848),
      child: ListTile(
        title: Text(b.title),
        subtitle: Text(b.year.toString()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.edit,color: Colors.white,)),
            const SizedBox(width: 10,),
            IconButton(onPressed: (){}, icon: const Icon(Icons.delete,color: Colors.white,))

          ],),
      ),
    );
  }

  void showAlert(context, bloc) {
    showDialog(
      context: context,
      builder: (context) =>
          BlocConsumer<BookBloc, BookState>(

            listener: (context, state) {
              if (state is BookFormValidState) {
                Navigator.pop(context);
              }
            },
            bloc: bloc,
            builder: (context, state) {
              return AlertDialog(
                title: const Text("Add New"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextField(
                        controller: _bookNameCon,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            errorText: state is BookNameErrorState
                                ? state.error
                                : null,
                            hintText: "Enter A Book Name"),
                        onChanged: (v) {
                          bloc.add(FormBookChangeEvent(v));
                        }
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _bookYearCon,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Enter A Book Year",
                        errorText: state is BookYearErrorState
                            ? state.error
                            : null,
                      ),
                      onChanged: (v) {
                        bloc.add(FormYearChangeEvent(v));
                      },
                    ),

                  ],
                ),
                actions: [
                  MaterialButton(onPressed: () {
                    bloc.add(FormSubmitEvent(_bookNameCon.text, _bookYearCon.text));
                  }, child: const Text("Add"),),
                ],
              );
            },
          ),
    );
  }
}
