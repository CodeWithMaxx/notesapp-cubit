import '../Model/notesmodel.dart';

abstract class NoteState{}

class initialState extends NoteState{}

class loadingState extends NoteState{}

class loadedState extends NoteState{
  List<NotesModel>noteList=[];
  loadedState({required this.noteList});
}

class errorState extends NoteState{
  String error;
  errorState({required this.error});
}
