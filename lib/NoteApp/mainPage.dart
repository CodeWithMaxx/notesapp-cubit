import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notebook/Cubit/noteCubit.dart';
import 'package:notebook/Cubit/notestate.dart';
import 'package:notebook/Model/notesmodel.dart';

import 'NoteView.dart';
import 'addNotepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      context.read<NotesCubit>().getallnotes();
    });
  }

  var heights = [
    {
      "height": 250,
    },
    {
      "height": 300,
    },
    {
      "height": 275,
    },
    {
      "height": 320,
    },
  ];
  var colors = [
    Colors.greenAccent,
    Colors.amber.shade100,
    Colors.deepPurpleAccent.shade100,
    Colors.pinkAccent.shade100,
    Colors.tealAccent,
    Colors.indigo.shade300
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "𝑵𝑶𝑻𝑬𝑩𝑶𝑶𝑲",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: BlocBuilder<NotesCubit, NoteState>(
        builder: (context, state) {
          if (state is loadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is loadedState) {
            return ListView.builder(
                itemCount: state.noteList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                    child: Container(
                      height: 150,
                      width: 480,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(18)),
                          color: colors[Random().nextInt(colors.length)]),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NotesView(
                                          state.noteList[index].id,
                                          state.noteList[index].title,
                                          state.noteList[index].desc)))
                              .then((result) {
                            if (result != null) {
                              // Handle the updated data from UpdateNotePage
                              // ignore: unused_local_variable
                              int updatedId = result['id'];
                              String updatedTitle = result['updatedTitle'];
                              String updatedDesc = result['updatedDesc'];

                              // Update the UI with the new data (e.g., add a new note)
                              context.read<NotesCubit>().addnotes(NotesModel(
                                  title: updatedTitle, desc: updatedDesc));
                            }
                          });
                        },
                        leading: CircleAvatar(
                          child: Text("${state.noteList[index].id}"),
                        ),
                        title: Text(
                          "${state.noteList[index].title}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text("${state.noteList[index].desc}"),
                        trailing: IconButton(
                            onPressed: () {
                              showAdaptiveDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog.adaptive(
                                      title: Text(
                                        "Warning",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                          "Are you sure to delete this note please confirm"),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Text(
                                                  "No",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  BlocProvider.of<NotesCubit>(
                                                          context)
                                                      .deletenotes(state
                                                          .noteList[index].id!);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Note Deleted")));
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              size: 27,
                            )),
                      ),
                    ),
                  );
                });
          } else if (state is errorState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Warning",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    content: Text("Database not found please try again"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ))
                    ],
                  );
                });
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addNotes()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
