import 'package:flutter/material.dart';
import 'package:my_notepad/components/custom_text_form_field.dart';
import 'package:my_notepad/model/notepad.dart';

import '../dao/notepad_dao.dart';

class EditNotepadDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Notepad notepad;

  EditNotepadDialog(this.notepad);

  Future<bool> _createNotepad(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await NotepadDao().update(notepad);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit notepad"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel")),
        TextButton(
            onPressed: () async {
              if (await _createNotepad(context)) {
                Navigator.pop(context, true);
              }
            },
            child: Text("Save")),
      ],
      content: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            CustomTextFormField(
              hintText: "Title",
              initialValue: notepad.title,
              onSaved: (newValue) => notepad.title = newValue!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title field is required";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hintText: "Description",
              initialValue: notepad.description,
              maxLines: 10,
              onSaved: (newValue) => notepad.description = newValue!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Description field is required";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
