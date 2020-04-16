import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:note_app/database/note_helper.dart';
import 'package:note_app/model/note.dart';

class ViewScreen extends StatefulWidget {
  final note;
  final noteTitle;
  final bool isEdit;

  const ViewScreen({Key key, this.note, this.noteTitle, this.isEdit = false})
      : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {

  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    isEdit = widget.isEdit;
    super.initState();
  }

  updateNote() {
    NoteHelper().updateNote(Note(
      "${_title.text}",
      "${_content.text}",
    ));
  }


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
        title: Text('Reading'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              _buildSaveEdit()
            ],
          ),
        ],
      ),
      body: isEdit ? _buildEdit() : _buildNoteDetails(),
    );
  }

  Widget _buildNoteDetails() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: Text(
              widget.noteTitle,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            widget.note,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildEdit() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: widget.noteTitle,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextField(
              decoration: InputDecoration.collapsed(
                  hintText: widget.note,
                  hintStyle: TextStyle(fontWeight: FontWeight.w700)),
            ),
          )
        ],
      ),
    );
  }

  _buildSaveEdit() {

    if(isEdit)
      return IconButton(
        icon: Icon( Feather.check),
        onPressed: () async {
          await saveNote();
          setState(() {
            isEdit = !isEdit;
          });
        },
      );
    else return  IconButton(
      icon: Icon( Feather.edit_2),
      onPressed: () async {
        await updateNote();
        setState(() {
          isEdit = !isEdit;
        });
      },
    );
  }
}
