import 'package:flutter/material.dart';
import 'package:my_notepad/components/create_notepad_dialog.dart';
import 'package:my_notepad/components/list_notepad.dart';
import 'package:my_notepad/dao/notepad_dao.dart';

import '../model/notepad.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Notepad>>? _futureNotepad;

  @override
  void initState() {
    _futureNotepad = NotepadDao().listAll();
    super.initState();
  }

  void updateList() {
    setState(() {
      _futureNotepad = NotepadDao().listAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Note"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => CreateNotepadDialog(),
          ).then((value) {
            if(value) {
              updateList();
            }
          });
        },
      ),
      body: FutureBuilder(
          future: _futureNotepad,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return ListNotepad(
                notepadList: snapshot.data!,
                updateList: updateList,
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
