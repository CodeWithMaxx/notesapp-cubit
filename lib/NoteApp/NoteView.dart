import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notebook/Cubit/notestate.dart';

import '../Cubit/noteCubit.dart';
import '../CustomWidgets/Ui.dart';

// ignore: must_be_immutable
class NotesView extends StatefulWidget {
  int? id;
  dynamic titleText;
  dynamic descText;
  NotesView(this.id, this.titleText, this.descText);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "𝐌𝐲 𝐍𝐨𝐭𝐞",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
      ),
      body: BlocBuilder<NotesCubit, NoteState>(
        builder: (context, state) {
          return Column(
            children: [
              CustomUI().customTf("Title", titleController),
              CustomUI().customTf1("Content", descController)
            ],
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.deepPurpleAccent.shade400,
          animationDuration: Duration(milliseconds: 00),
          items: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Note Updated"),
                    duration: Duration(seconds: 1),
                  ));
                  BlocProvider.of<NotesCubit>(context).updatenotes(
                    widget.id!,
                    titleController.text.toString(),
                    descController.text.toString(),
                  );
                  context.read<NotesCubit>().getallnotes();
                  Navigator.pop(
                    context,
                    {
                      'id': widget.id,
                      'updatedTitle': titleController.text,
                      'updatedDesc': descController.text,
                    },
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.edit,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Warning",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          content: Text(
                              "Are you sure to delete this ${titleController.text} please confirm"),
                          actions: [
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                    onPressed: () {
                                      BlocProvider.of<NotesCubit>(context)
                                          .deletenotes(widget.id!);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            )
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  size: 27,
                  color: Colors.white,
                ))
          ]),
    );
  }
}
