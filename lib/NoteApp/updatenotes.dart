import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebook/Cubit/noteCubit.dart';
import 'package:notebook/Cubit/notestate.dart';

import '../CustomWidgets/Ui.dart';
import 'mainPage.dart';

class UpdateNotes extends StatefulWidget {
  int? id;
  dynamic titleText;
  dynamic descText;
  UpdateNotes({this.id,required this.titleText,required this.descText});

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  late TextEditingController titleController;
  late TextEditingController descController;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.titleText);
    descController = TextEditingController(text: widget.descText);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit,NoteState>(
      builder: (context,state){
       return Scaffold(
         appBar: AppBar(
           title: Text("UpDate Your Notes",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
           centerTitle: true,
           backgroundColor: Colors.deepPurple,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
         ),
         body:Column(
           children:[
             CustomUI().customTf("Title",titleController),
             CustomUI().customTf1("Content",descController)
           ],
         ),
         floatingActionButton: FloatingActionButton.extended(onPressed: (){
          context.read<NotesCubit>().updatenotes(widget.id!, titleController.text.toString(), descController.text.toString());
         }, label: Text("UPDATE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
         icon: Icon(Icons.edit_location_outlined),
         ),
        );
      },
    );
  }
}
