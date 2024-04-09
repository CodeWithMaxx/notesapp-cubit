import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:notebook/Cubit/notestate.dart';
import 'package:notebook/DbHelper/dbhelper.dart';
import 'package:notebook/Model/notesmodel.dart';

class NotesCubit extends Cubit<NoteState>{
  DbHelper myDb;
  NotesCubit({required this.myDb}):super(initialState());

  Future<void>addnotes(NotesModel notesModel)async{
    emit(loadingState());
    bool check = await myDb.inserallnotes(notesModel);
    if(check){
      final notes = await myDb.getData();
      emit(loadedState(noteList: notes));
    }
  }
getallnotes()async{
    emit(loadingState());
    final notes = await myDb.getData();
    emit(loadedState(noteList: notes));
}

updatenotes(int id,String title, String desc)async{
    bool check=await myDb.updatenotes(NotesModel(id: id,title: title, desc: desc));
    if(check){
      emit(loadedState(noteList: await myDb.getData()));
    }
    log("an error accured");
}
deletenotes(int id)async{
    emit(loadingState());
    bool check = await myDb.deletenotes(id);
    if(check){
      final notes = await myDb.getData();
      emit(loadedState(noteList: notes));
    }
    else{
      log("an error accured");
    }
}
}