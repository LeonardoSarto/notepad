import 'package:flutter/material.dart';
import 'package:my_notepad/components/edit_notepad_dialog.dart';
import 'package:my_notepad/dao/notepad_dao.dart';
import 'package:my_notepad/model/notepad.dart';

class ListNotepad extends StatefulWidget {
  final List<Notepad> notepadList;
  void Function()? updateList;

  ListNotepad({super.key, required this.notepadList, this.updateList});

  @override
  State<ListNotepad> createState() => _ListNotepadState();
}

class _ListNotepadState extends State<ListNotepad> {
  bool selectNotepads = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.notepadList.length,
      itemBuilder: (context, index) {
        Notepad notepad = widget.notepadList[index];

        return Dismissible(
          direction: DismissDirection.endToStart,
          key: GlobalKey(),
          onDismissed: (direction) async {
            await NotepadDao().delete(notepad.id!);
            widget.updateList!();
          },
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
          child: MaterialButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => EditNotepadDialog(notepad))
                  .then((value) {
                if(value) {
                  widget.updateList!();
                }
              });
            },
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(notepad.title),
              subtitle:
                  Text(notepad.description, overflow: TextOverflow.ellipsis),
            ),
          ),
        );
      },
    );
  }
}
