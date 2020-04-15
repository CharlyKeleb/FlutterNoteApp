import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:note_app/database/note_helper.dart';
import 'package:note_app/model/note.dart';

class Notes extends StatefulWidget {
  final title;

  const Notes({Key key, this.title}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();

  saveNote(){
    NoteHelper().saveNote(
      Note(
        "${_title.text}",
        "${_content.text}",
      ),
    ).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Text(
          'Editor',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Feather.save),
            onPressed: () => saveNote(),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              height: MediaQuery.of(context).size.height - 20,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextField(
                      controller: _title,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Note Title', hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextField(
                          controller: _content,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                              hintText: 'Type Notes...'),
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
