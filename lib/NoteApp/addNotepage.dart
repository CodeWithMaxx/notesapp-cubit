import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebook/Cubit/noteCubit.dart';
import 'package:notebook/Cubit/notestate.dart';
import 'package:notebook/CustomWidgets/Ui.dart';
import 'package:notebook/Model/notesmodel.dart';

class addNotes extends StatefulWidget {
  const addNotes({super.key});

  @override
  State<addNotes> createState() => _addNotesState();
}

class _addNotesState extends State<addNotes> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getallnotes();
  }
  final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit,NoteState>(
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text("Add Your Notes",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white),),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
              TextField(
              controller: titleController,
              maxLines: null,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none
              ),
            ),
            TextField(
              controller: descController,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Content",
                  border: InputBorder.none
              ),
            )
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
              color: Colors.deepPurpleAccent,
              animationDuration: Duration(milliseconds: 400),
              items:[
                IconButton(onPressed: (){
                  String title =titleController.text.toString();
                  String desc = descController.text.toString();
                  if(title=="" && desc==""){
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.grey,
                        title: Text("Warning",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        content: Text("Please fill required fields"),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text("ok",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),))
                        ],
                      );
                    }
                    );
                  }
                  else{
                    BlocProvider.of<NotesCubit>(context).addnotes(NotesModel(title: title, desc: desc));
                    BlocProvider.of<NotesCubit>(context).getallnotes();
                    Navigator.pop(context);
                  }
                }, icon: Icon(Icons.save))
              ]
          ),
        );
      },
    );
  }
}
