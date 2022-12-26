import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_repository_pattern/search/custom_search.dart';

import '../bloc/book_bloc.dart';
import '../models/book.dart';

class BookList extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BookBloc>(context) ;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
        actions:  [
         IconButton(onPressed: (){
           showSearch(context: context,
               delegate: CustomSearch(bloc.bookList));

         }, icon:  const Icon(Icons.search))
        ],
      ),
      body: BlocConsumer<BookBloc, BookState>(
        bloc: bloc,
        listener: (context, state) {
          if(state is BookEditState)
          {
            showAlert(context, bloc,b: state.book,editAble: true);
          }
        },
        builder: (context, state) {
          return state is BookLoadingState && state.load?const Center(child: CupertinoActivityIndicator(color: Colors.white,)):
          RefreshIndicator(
            onRefresh: () async{

              bloc.add(FetchBookEvent());
            },
            child: ListView.builder(
              itemCount: bloc.bookList.length,
              itemBuilder: (context, index) {
                return myCard(bloc.bookList[index],context);
              },
            ),
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

  Widget myCard(Book b,context) {
    return Card(
      elevation: 1.5,
      color:  const Color(0xFF4B4848),
      child: ListTile(
        title: Text(b.title),
        subtitle: Text(b.year.toString()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: (){
              BlocProvider.of<BookBloc>(context).add(EditBookEvent(b));
            }, icon: const Icon(Icons.edit,color: Colors.white,size: 18,)),
            const SizedBox(width: 10,),
            IconButton(onPressed: (){
              BlocProvider.of<BookBloc>(context).add(DeleteBookEvent(b.id));

            }, icon: const Icon(Icons.delete,color: Colors.white,size: 18,))

          ],),
      ),
    );
  }

  void showAlert(context, bloc,{  Book? b,bool editAble=false}) {
    final TextEditingController bookNameCon = TextEditingController();
    final TextEditingController bookYearCon = TextEditingController();

    if(editAble)
    {
      bookNameCon.text=b!.title;
      bookYearCon.text=b.year.toString();
    }
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
                title:  Text(editAble?"Edit":"Add New"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextField(
                        controller: bookNameCon,
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
                      controller: bookYearCon,
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
                    if(editAble)
                    {
                      bloc.add(EditSubmitEvent(Book(b!.id, bookNameCon.text, int.parse(bookYearCon.text))));
                    }
                    else
                    {
                      bloc.add(FormSubmitEvent(bookNameCon.text, bookYearCon.text));

                    }
                  }, child: const Text("Add"),),
                ],
              );
            },
          ),
    );
  }
}
